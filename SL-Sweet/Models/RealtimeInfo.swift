//
//  RealtimeInfo.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation


struct RealtimeInfo: Decodable {
    var ResponseData: RealtimeResponse
}

struct RealtimeResponse: Decodable {
    var Metros: [Metro]
    var Buses: [Bus]
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
