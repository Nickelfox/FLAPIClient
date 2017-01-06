//
//  AuthHeaders.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient

public struct AuthHeaders: AuthHeadersProtocol {
	let uid: String
	let expiry: Date
	let client: String
	let accessToken: String
	
	public static func parse(_ json: JSON) throws -> AuthHeaders {
		return try AuthHeaders(
			uid: json[uidKey]^,
			expiry: parseDateFromUnixTimestamp(json[expiryKey]),
			client: json[clientKey]^,
			accessToken: json[accessTokenKey]^
		)
	}
	
	public func toJSON() -> [String: String] {
		let res: [String: String] = [
			uidKey: self.uid,
			expiryKey: String(self.expiry.timeIntervalSince1970),
			clientKey: self.client,
			accessTokenKey: self.accessToken,
			]
		return res
	}
	
	public var isValid: Bool {
		return !self.uid.isEmpty &&
			!self.client.isEmpty &&
			!self.accessToken.isEmpty &&
			(self.expiry > Date())
	}
	
}

fileprivate func parseDateFromUnixTimestamp(_ json: JSON) throws -> Date {
	let timestamp: TimeInterval
	if let timestampString: String = try? json^,
		let timestampParsed = TimeInterval(timestampString)
	{
		timestamp = timestampParsed
	} else {
		timestamp = try json^
	}
	let date = Date(timeIntervalSince1970: timestamp)
	return date
}

extension AuthHeaders {
	public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
		var urlRequest = urlRequest
		urlRequest.setValue(self.accessToken, forHTTPHeaderField: "Access-Token")
		urlRequest.setValue(self.client, forHTTPHeaderField: "Client")
		urlRequest.setValue(self.uid, forHTTPHeaderField: "Uid")
		return urlRequest
	}
}


private let uidKey = "uid"
private let expiryKey = "expiry"
private let clientKey = "client"
private let accessTokenKey = "access-token"
