//
//  FlightRowModel.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/12.
//

import Foundation

final class FlightRowModel: ObservableObject {
    private let database = DataBaseManager.shared
    
    func addFavorites(flightInfo: FlightOpratInfo) {
        let task = FavoritesEntity(uuid: UUID(), airlineNm: flightInfo.airlineNm, arrAirportNm: flightInfo.arrAirportNm, arrPlandTime: flightInfo.arrPlandTime, depAirportNm: flightInfo.depAirportNm, depPlandTime: flightInfo.depPlandTime, economyCharge: flightInfo.economyCharge, prestigeCharge: flightInfo.prestigeCharge, vihicleId: flightInfo.vihicleId)
        database.getLocationOfDefaultRealm()
        database.write(task)
    }
    
    func deleteFavorites(flightInfo: FlightOpratInfo) {
        let task = database.read(FavoritesEntity.self).filter("vihicleId == '\(flightInfo.vihicleId)' AND arrPlandTime == \(flightInfo.arrPlandTime)").first
        database.delete(task!)
    }
    
    func checkFavorite(flightInfo: FlightOpratInfo) -> Bool {
        let task = database.read(FavoritesEntity.self).filter("vihicleId == '\(flightInfo.vihicleId)' AND arrPlandTime == \(flightInfo.arrPlandTime)")
        if task.isEmpty {
            return false
        }
        else {
            return true
        }
    }
}
