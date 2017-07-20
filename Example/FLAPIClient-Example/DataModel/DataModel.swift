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

typealias APICompletion1<T> = (APIResult<T>) -> Void

class DataModel {

	static func demo(completion: @escaping APICompletion1<DemoObject>) {
		
		let requestManager = RequestManager(baseUrl: URL.init(string: "https://httpbin.org")!)
		requestManager.headers = ["Content-Type": "application/json"]
		
		let request = requestManager.get(
			path: "/get", timeoutInterval: nil
		)
		
		FoxAPIClient.shared.request(router: request, completion: completion)
		
	}

}
