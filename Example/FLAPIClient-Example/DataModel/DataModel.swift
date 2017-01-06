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

	static func demo(completion: @escaping APICompletion<NoResponse>) {
		FoxAPIClient.shared.request(
			route: Router.demo,
			completion: completion
		)
	}

}
