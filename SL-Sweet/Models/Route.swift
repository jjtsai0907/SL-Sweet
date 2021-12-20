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

enum TrafficCategory: String {
    case metro = "metro"
    case train = "train"
    case local = "local"
    case tram = "tram"
    case bus = "bus"
    case ferry = "fer"
    case unknown = "unknown"
}

struct TrafficType: Decodable {
    var Name: String
    var `Type`: String
    var Events: [EventsInfo]

    func currentCategory() -> TrafficCategory {
        return TrafficCategory(rawValue: Type) ?? .unknown
    }
}

struct EventsInfo : Decodable {
    var EventId: Int
    var Message: String
}
