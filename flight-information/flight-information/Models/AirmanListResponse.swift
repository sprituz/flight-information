//
//  AirmanListResponse.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//


struct AirmanListResponse: Codable {
    let response: AirmanListResponseBody
}

struct AirmanListResponseBody: Codable {
    let header: Header
    let body: AirmanListBody
}

struct AirmanListBody: Codable {
    let items:AirLineItems
}

struct AirLineItems: Codable {
    let item: [Airline]
}

struct Airline : Codable, Hashable{
    var airlineId : String
    var airlineNm : String
}
