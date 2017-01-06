//
//  ErrorResponse.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
	public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
		let unknownError = APIErrorType.mapping(message: "Error Response can't be mapped.").error
		if let _ = json[errorKey].object {
			return try ErrorResponse(
				code: .other(code: code),
				messages: json[errorKey].array.map(^)
			)
		} else {
			throw unknownError
		}
	}

	public var code: APIErrorCode
	public let messages: [String]
	
	public var compiledErrorMessage: String {
		return self.messages.joined(separator: ",")
	}
}

public extension ErrorResponse {
	
	var error: APIError {
		return APIError(
			code: self.code,
			message: self.compiledErrorMessage
		)
	}
	
}
