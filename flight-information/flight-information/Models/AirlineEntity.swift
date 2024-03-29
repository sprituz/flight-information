//
//  AirlineEntity.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import Foundation
import RealmSwift

final class AirlineEntity: Object {
    @objc dynamic var airlineId: String = ""
    @objc dynamic var airlineNm : String? = ""
    
    override init() { }

    init(airlineId:String, airlineNm: String) {
        self.airlineId = airlineId
        self.airlineNm = airlineNm
       }
    
    override static func primaryKey() -> String? {
      return "airlineId"
    }
}
