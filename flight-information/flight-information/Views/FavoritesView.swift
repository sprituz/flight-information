//
//  FavoritesView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesViewModel:FavoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if let favoriteInfos = favoritesViewModel.favoriteInfos {
                    ForEach(favoriteInfos) { favorite in
                        let flightInfo:FlightOpratInfo = FlightOpratInfo(airlineNm: favorite.airlineNm, arrAirportNm: favorite.arrAirportNm, arrPlandTime: favorite.arrPlandTime, depAirportNm: favorite.depAirportNm, depPlandTime: favorite.depPlandTime, economyCharge: favorite.economyCharge, prestigeCharge: favorite.prestigeCharge, vihicleId: favorite.vihicleId)
                        NavigationLink(destination: FlightDetailView(flightInfo: flightInfo)) {
                            flightRow(flightInfo: flightInfo)
                        }
                    }
                } else {
                    Text("No data available")
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
