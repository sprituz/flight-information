//
//  AirportEntity.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import Foundation
import RealmSwift

final class AirportEntity: Object {
    @objc dynamic var airportId: String = ""
    @objc dynamic var airportNm : String? = ""
    
    override static func primaryKey() -> String? {
      return "airportId"
    }
}
