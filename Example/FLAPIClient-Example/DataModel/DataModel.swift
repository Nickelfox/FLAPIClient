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
		let request = APIRequestManager.shared.get(
			path: "/get", timeoutInterval: nil
		)
		
		FoxAPIClient.shared.request(router: request, completion: completion)
		
	}

	static func demo1(completion: @escaping APICompletion1<String>) {
		let request = APIRequestManager.shared.get(
			path: "/get",
			keypathToMap: "headers.Host"
		)
		FoxAPIClient.shared.request(router: request, completion: completion)
	}

}
