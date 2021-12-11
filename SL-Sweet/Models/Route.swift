//
//  Route.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-07.
//

import Foundation


struct ExecutionTime: Decodable {
    var ExecutionTime: Int
}


struct TrafficResponse: Decodable {
    var ResponseData: TraficTypes
}


struct TraficTypes: Decodable {
    var TrafficTypes: [TrafficType]
}


struct TrafficType: Decodable {
    var Name: String
    var Events: [EventsInfo]
}

struct EventsInfo : Decodable {
    var EventId: Int
    var Message: String
}
