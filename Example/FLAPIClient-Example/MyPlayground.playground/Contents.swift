//: Playground - noun: a place where people can play

import UIKit
import FLAPIClient
import SwiftyJSON

let jsonData = "{\"activities\": {\"running\": {\"distance\": false}}}"

let data = jsonData.data(using: .utf8)!
let json = JSON(data: data)
struct Object: JSONParsing {
	
	let status: Bool
	
	static func parse(_ json: JSON) throws -> Object {
		return try Object(status: json["activities"]["running"]["distance"]^)
//		activities.running.distance
	}
	
}


do {
	let object = try Object.parse(json)
	print(object.status)
} catch {
	print(error)
}
