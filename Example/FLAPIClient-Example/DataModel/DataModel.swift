//
//  DataModel.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient

typealias APICompletion<T> = (APIResult<T>) -> Void

class DataModel {

	static func demo(completion: @escaping APICompletion<DemoObject>) {
		let params = ["values": ["one", "two"]]
		let request = APIRequestManager.shared.get(
			path: "/anything",
			params: params,
			timeoutInterval: nil
		)
		FoxAPIClient.shared.request(router: request, completion: completion)
		
	}

}
