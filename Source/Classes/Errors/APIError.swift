//
//  APIError.swift
//  Network
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation

public struct APIErrorDefaults {
	public static let code = APIErrorCode.unknown
	public static let title = "Error"
	public static let message = "An unknown error has occured."
	
	public static let mappingErrorTitle = "Mapping Error"
	public static let mappingErrorMessage = "An unknown error occured while mapping response"
}

public protocol APIError: Error {
	var code: Int { get }
	var title: String { get }
	var message: String { get }
}


public extension NSError {

	public var title: String {
		return self.domain
	}

	public var message: String {
		return (self.userInfo[NSLocalizedDescriptionKey] as? String) ?? APIErrorDefaults.message
	}

}
