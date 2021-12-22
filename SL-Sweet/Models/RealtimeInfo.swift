//
//  RealtimeInfo.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation

struct RealtimeResponse: Decodable {
    var ResponseData: Metros
}




struct Metros: Decodable {
    var Metros: [Metro]
}


struct Metro: Decodable {
    var GroupOfLine: String
    var DisplayTime: String
    var TransportMode: String
    var Destination: String
}
