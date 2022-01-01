//
//  RealtimeInfo.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation


struct RealtimeInfo: Decodable {
    var ResponseData: RealtimeResponse = RealtimeResponse(Metros: [Metro](), Buses: [Bus](), Trains: [Train](), Trams: [Tram](), Ships: [Ship]())
    
}

struct RealtimeResponse: Decodable {
    var Metros: [Metro]
    var Buses: [Bus]
    var Trains: [Train]
    var Trams: [Tram]
    var Ships: [Ship]
}


struct Metro: Decodable {
    var GroupOfLine: String
    var TransportMode: String
    var LineNumber: String
    var Destination: String
    var DisplayTime: String
}


struct Bus: Decodable {
    var TransportMode: String
    var LineNumber: String
    var Destination: String
    var DisplayTime: String
}

struct Train: Decodable {
    var GroupOfLine: String
    var TransportMode: String
    var LineNumber: String
    var Destination: String
    var DisplayTime: String
}

struct Tram: Decodable {
    var GroupOfLine: String
    var TransportMode: String
    var LineNumber: String
    var Destination: String
    var DisplayTime: String
}

struct Ship: Decodable {
    var GroupOfLine: String
    var TransportMode: String
    var LineNumber: String
    var Destination: String
    var DisplayTime: String
}
