//
//  FlightOpratInfoListResponse.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

struct FlightOpratInfoListResponse: Codable {
    let response: FlightOpratInfoListResponseBody
}

struct FlightOpratInfoListResponseBody: Codable {
    let header: Header
    let body: FlightOpratInfoListBody
}

struct FlightOpratInfoListBody: Codable {
    let items:FlightOpratInfoItems
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct FlightOpratInfoItems: Codable {
    let item: [FlightOpratInfo]
}

struct FlightOpratInfo : Codable, Hashable{
    var airlineNm : String
    var arrAirportNm : String
    var arrPlandTime : Int
    var depAirportNm : String
    var depPlandTime : Int
    var economyCharge : Int
    var prestigeCharge : Int
    var vihicleId : String
}
