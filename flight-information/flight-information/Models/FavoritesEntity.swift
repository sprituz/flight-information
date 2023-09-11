//
//  FavoritesEntity.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import Foundation
import RealmSwift

final class FavoritesEntity: Object, Identifiable {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var airlineNm : String = ""
    @objc dynamic var arrAirportNm : String = ""
    @objc dynamic var arrPlandTime : Int = 0
    @objc dynamic var depAirportNm : String = ""
    @objc dynamic var depPlandTime : Int = 0
    @objc dynamic var economyCharge : Int = 0
    @objc dynamic var prestigeCharge : Int = 0
    @objc dynamic var vihicleId : String = ""
    
    override init() { }

    init(uuid: UUID, airlineNm: String, arrAirportNm: String, arrPlandTime: Int,depAirportNm:String,depPlandTime:Int, economyCharge:Int,prestigeCharge:Int, vihicleId:String) {
        self.uuid = uuid
        self.airlineNm = airlineNm
        self.arrAirportNm = arrAirportNm
        self.arrPlandTime = arrPlandTime
        self.depAirportNm = depAirportNm
        self.depPlandTime = depPlandTime
        self.economyCharge = economyCharge
        self.prestigeCharge = prestigeCharge
        self.vihicleId = vihicleId
       }

       override class func primaryKey() -> String? {
           "uuid"
       }
}
