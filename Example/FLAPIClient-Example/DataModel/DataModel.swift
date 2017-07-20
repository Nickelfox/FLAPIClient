//
//  DataModel.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient

typealias APICompletion<T> = (T?, APIError?) -> Void

class DataModel {

	static func demo(completion: @escaping APICompletion<DemoObject>) {
		
		let requestManager = RequestManager(baseUrl: URL.init(string: "https://httpbin.org")!)
		requestManager.headers = ["Content-Type": "application/json"]
		
		let request = requestManager.get(
			path: "/get", timeoutInterval: nil
		)
		FoxAPIClient.shared.request(router: request) { (code: DemoObject?, error) in
				completion(code, error)
		}

	}

}
