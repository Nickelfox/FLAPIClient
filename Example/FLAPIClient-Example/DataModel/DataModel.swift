//
//  DataModel.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient
import ReactiveSwift

typealias APICompletion<T> = (T?, APIError?) -> Void

class DataModel {

	static func demo(completion: @escaping APICompletion<DemoObject>) {
		FoxAPIClient.shared.request(
			route: Router.demo,
			completion: completion
		)
	}

	static func demo() -> SignalProducer<DemoObject, APIError> {
		return FoxAPIClient.shared.request(route: Router.demo)
	}

}
