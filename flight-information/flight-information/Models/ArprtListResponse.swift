//
//  ArprtListResponse.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import Foundation


struct ArprtListResponse: Codable {
    let response: ArprtListResponseBody
}

struct ArprtListResponseBody: Codable {
    let header: Header
    let body: ArprtListBody
}

struct Header: Codable {
    let resultCode: String
    let resultMsg: String
}

struct ArprtListBody: Codable {
    let items: ArprtListItems
}

struct ArprtListItems: Codable {
    let item: [Airport]
}

struct Airport : Codable, Hashable{
    var airportId : String
    var airportNm : String
}
