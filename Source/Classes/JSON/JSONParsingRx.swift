//
//  JSONParsingRx.swift
//  APIClient
//
//  Created by Ravindra Soni on 15/10/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

/*
import ReactiveSwift

protocol JSONParsingRx: JSONParsing {
	static func parseRx<T: JSONParsing>(json: JSON) -> SignalProducer<T, APIError>
}

extension JSONParsingRx {
	static func parseRx<T: JSONParsing>(json: JSON) -> SignalProducer<T, APIError> {
		return SignalProducer { sink, observer in
			do {
				let result = try T.parse(json)
				sink.send(value: result)
				sink.sendCompleted()
			} catch JSON.Error.noValue(let json) {
				let desc = "JSON value not found at key path \(json.pathFromRoot)"
				sink.send(error: APIErrorType.mapping(message: desc).error)
			} catch JSON.Error.typeMismatch(let json) {
				let desc = "JSON value type mismatch at key path \(json.pathFromRoot)"
				sink.send(error: APIErrorType.mapping(message: desc).error)
			} catch {
				sink.send(error: APIErrorType.mapping(message: nil).error)
			}
		}
	}
}
*/
