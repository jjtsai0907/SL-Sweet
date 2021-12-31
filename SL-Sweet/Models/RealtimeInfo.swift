//
//  RealtimeInfo.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation


struct RealtimeInfo: Decodable {
    var ResponseData: RealtimeResponse = RealtimeResponse(Metros: [Metro](), Buses: [Bus](), Trains: [Train](), Ships: [Ship]())
    
}

struct RealtimeResponse: Decodable {
    var Metros: [Metro]
    var Buses: [Bus]
    var Trains: [Train]
    var Ships: [Ship]
}


struct Metro: Decodable {
    var GroupOfLine: String
    var DisplayTime: String
    var TransportMode: String
    var Destination: String
}


struct Bus: Decodable {
    var LineNumber: String
    var DisplayTime: String
    var TransportMode: String
}

struct Train: Decodable {
    
}

struct Tram: Decodable {
    
}

struct Ship: Decodable {
    var TransportMode: String
    var LineNumber: String
    var Destination: String
    var GroupOfLine: String
    var StopAreaName: String
    var DisplayTime: String
    var JourneyNumber: Int
}
