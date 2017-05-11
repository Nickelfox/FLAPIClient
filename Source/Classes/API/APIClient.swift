//
//  APIClient.swift
//  Network
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation
//import ReactiveSwift
//import Result
import Alamofire
import SwiftyJSON

private let AuthHeadersKey = "AuthHeadersKey"

open class APIClient<U: AuthHeadersProtocol, V: ErrorResponseProtocol> {

	public var enableLogs = false
	
	public init() {
		self.networkManager = NetworkReachabilityManager()
		self.sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
		let profileJSON = self.currentProfile
		self.authHeaders = try? SwiftyJSON.JSON(profileJSON as Any)^
	}
	
	private var currentProfile: Any? {
		get {
			return UserDefaults.standard.object(forKey: AuthHeadersKey)
		} set {
			UserDefaults.standard.set(newValue, forKey: AuthHeadersKey)
			UserDefaults.standard.synchronize()
		}
	}

	public var authHeaders: U? = nil {
		didSet {
			guard let authHeaders = self.authHeaders else {
				self.sessionManager.adapter = nil
				return
			}
			self.sessionManager.adapter = authHeaders
			self.currentProfile = authHeaders.toJSON()
		}
	}

	public var isAuthenticated: Bool {
		if let headers = self.authHeaders {
			return headers.isValid
		}
		return false
	}
	
	fileprivate let sessionManager: SessionManager
	fileprivate let networkManager: NetworkReachabilityManager?
	
	//Override this method in the subclass to st auth headers from the responses.
	open func parseAuthenticationHeaders (_ response: HTTPURLResponse) {

	}

	fileprivate var isNetworkReachable: Bool {
		guard let networkManager = self.networkManager  else {
			return false
		}
		return networkManager.isReachable
	}
	
	open func clearAuthHeaders() {
		self.authHeaders = nil
	}
	
}

////MARK: Reactive
//extension APIClient {
//
//	public func request<T: JSONParsing> (route: APIRouter) -> SignalProducer<T, APIError> {
//		
//		return SignalProducer { sink, disposable in
//			
//			let request =
//			APIClient.sharedInstance.requestInternal(route: route, completion: {
//				(result: T?, error) -> Void in
//				guard let result = result else {
//					sink.send(error: error!)
//					return
//				}
//				sink.send(value: result)
//				sink.sendCompleted()
//			})
//
//			disposable.add {
//				request.cancel()
//			}
//			}.observe(on: UIScheduler())
//	}
//
//}

//MARK: Non-Reactive
extension APIClient {

	public func request<T: JSONParsing> (route: APIRouter, completion: @escaping (_ result: T?, _ error: APIError?) -> Void) {
		let _ = self.requestInternal(route: route, completion: completion)
	}

	fileprivate func requestInternal<T: JSONParsing> (route: APIRouter, completion: @escaping (_ result: T?, _ error: APIError?) -> Void) -> Request {
		
		let completionHandler: (_ result: T?, _ error: APIError?) -> Void = { result, error in
			DispatchQueue.main.async {
				completion(result, error)
			}
		}
		
		//Reachability Check
		if !self.isNetworkReachable {
			completionHandler(nil, APIErrorType.noInternet.error)
		}
		
		//Make request
		let request = self.sessionManager.request(route)
		if self.enableLogs {
			request.log()
		}
		
		request.response { [unowned self] response in
			if self.enableLogs {
				response.log()
			}
			//Parse Auth Headers
			func handleResult(resultValue: Any?, code: Int) {
				if let httpResponse = response.response {
					self.parseAuthenticationHeaders(httpResponse)
				}
				do {
					let result: T = try self.parse(resultValue, code)
					completionHandler(result, nil)
				} catch let apiError as APIError {
					completionHandler(nil, apiError)
				} catch {
					completionHandler(nil, (error as NSError).apiError)
				}
			}

			if let data = response.data {
				do {
					let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
					if let code = response.response?.statusCode {
						if code >= 200 && code <= 299 {
							handleResult(resultValue: jsonObject, code: code)
						} else {
							completionHandler(nil, self.parseError(jsonObject, code))
						}
					} else {
						handleResult(resultValue: jsonObject, code: 0)
					}
				} catch {
					handleResult(resultValue: nil, code: 0)
				}
			} else {
				handleResult(resultValue: nil, code: 0)
			}
		}
		
//		request.responseJSON { [unowned self] response in
//			if self.enableLogs {
//				print("response is \(response)")
//			}
//			switch response.result {
//			case .success(let resultValue):
//				//Parse Auth Headers
//				func handleResult(resultValue: Any, code: Int) {
//					if let httpResponse = response.response {
//						self.parseAuthenticationHeaders(httpResponse)
//					}
//					do {
//						let result: T = try self.parse(resultValue, code)
//						completionHandler(result, nil)
//					} catch let apiError as APIError {
//						completionHandler(nil, apiError)
//					} catch {
//						completionHandler(nil, (error as NSError).apiError)
//					}
//				}
//				if let code = response.response?.statusCode {
//					if code >= 200 && code <= 299 {
//						handleResult(resultValue: resultValue, code: code)
//					} else {
//						completionHandler(nil, self.parseError(resultValue, code))
//					}
//				} else {
//					handleResult(resultValue: resultValue, code: 0)
//				}
//			case .failure(let error):
//				completionHandler(nil, self.parseError(error as NSError?))
//			}
//		}
		return request
	}

	fileprivate func parse<T: JSONParsing> (_ object: Any?, _ statusCode: Int) throws -> T {
		let json = JSON(object as AnyObject?)
		do {
			//try parsing error response
			if let errorResponse = try? V.parse(json, code: statusCode) {
				throw errorResponse.error
			}
			return try T.parse(json)
		} catch ParseError.noValue(let json) {
			let desc = "JSON value not found at key path \(json)"
			throw APIErrorType.mapping(message: desc).error
		} catch ParseError.typeMismatch(let json) {
			let desc = "JSON value type mismatch at key path \(json)"
			throw APIErrorType.mapping(message: desc).error
		} catch let apiError as APIError {
			throw apiError
		} catch {
			throw APIErrorType.unknown.error
		}
	}
	
	
	fileprivate func parseError(_ object: Any?, _ statusCode: Int) -> APIError {
		let json = JSON(object as AnyObject?)
		if statusCode == 403 {
			return APIErrorType.unauthorized.error
		} else if statusCode == 503 {
			return APIErrorType.serverDown.error
		} else {
			if let errorResponse = try? V.parse(json, code: statusCode) {
				return errorResponse.error
			} else {
				return APIErrorType.unknown.error
			}
		}
	}
	
	fileprivate func parseError(_ error: NSError?) -> APIError {
		if let error = error {
			return error.apiError
		} else {
			return APIErrorType.unknown.error
		}
	}

}

extension Request {

	func log() {
		if let request = self.request,
			let url = request.url,
			let headers = request.allHTTPHeaderFields,
			let method = request.httpMethod {
			print("Request: \(method) \(url)")
			print("Headers: \(headers)")
			if let data = request.httpBody, let params = String.init(data: data, encoding: .utf8) {
				print("Params: \(params)")
			}
		}
	}
	
}

extension DefaultDataResponse {

	func log() {
		if let response = self.response,
			let data = self.data,
			let utf8 = String.init(data: data, encoding: .utf8),
			let url = self.request?.url {
			let statusCode = response.statusCode
			print("Response for \(url):")
			print("Status Code: \(statusCode)")
			print("Data: \(utf8)")
		}
	}

	
}
