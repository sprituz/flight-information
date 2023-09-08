//
//  FavoritesEntity.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import Foundation
import RealmSwift

final class FavoritesEntity: Object {
    @objc dynamic var airlineNm : String = ""
    @objc dynamic var arrAirportNm : String = ""
    @objc dynamic var arrPlandTime : Int = 0
    @objc dynamic var depAirportNm : String = ""
    @objc dynamic var depPlandTime : Int = 0
    @objc dynamic var economyCharge : Int = 0
    @objc dynamic var prestigeCharge : Int = 0
    @objc dynamic var vihicleId : String = ""
}
