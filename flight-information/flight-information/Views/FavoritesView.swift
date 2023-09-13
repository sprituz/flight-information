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
                if let favoriteInfos = favoritesViewModel.fliteredFavoriteInfos?.freeze() {
                    if favoriteInfos.isEmpty {
                        HStack{
                            Text("출발공항")
                            Spacer()
                            DropdownView(selected: $favoritesViewModel.selectedDepartAirport,
                                         list: $favoritesViewModel.airportList) { airport in
                                "\(airport)"
                            }contentAppearance: { airport in
                                Text("\(airport)")
                            }.frame(width: 250)
                        }
                        HStack {
                            Text("항공사")
                            Spacer()
                            DropdownView(selected: $favoritesViewModel.selectedAirline,
                                         list: $favoritesViewModel.airlineList) { airline in
                                "\(airline)"
                            }contentAppearance: { airline in
                                Text("\(airline)")
                            }.frame(width: 250)
                        }
                        Text("즐겨찾기한 항공운항정보가 없습니다.")
                    }
                    else {
                        HStack{
                            Text("출발공항")
                            Spacer()
                            DropdownView(selected: $favoritesViewModel.selectedDepartAirport,
                                         list: $favoritesViewModel.airportList) { airport in
                                "\(airport)"
                            }contentAppearance: { airport in
                                Text("\(airport)")
                            }.frame(width: 250)
                        }
                        HStack {
                            Text("항공사")
                            Spacer()
                            DropdownView(selected: $favoritesViewModel.selectedAirline,
                                         list: $favoritesViewModel.airlineList) { airline in
                                "\(airline)"
                            }contentAppearance: { airline in
                                Text("\(airline)")
                            }.frame(width: 250)
                        }
                        ForEach(favoriteInfos, id: \.uuid) { favorite in
                            let flightInfo:FlightOpratInfo = FlightOpratInfo(airlineNm: favorite.airlineNm, arrAirportNm: favorite.arrAirportNm, arrPlandTime: favorite.arrPlandTime, depAirportNm: favorite.depAirportNm, depPlandTime: favorite.depPlandTime, economyCharge: favorite.economyCharge, prestigeCharge: favorite.prestigeCharge, vihicleId: favorite.vihicleId)
                            NavigationLink(destination: FlightDetailView(flightInfo: flightInfo)) {
                                flightRow(flightInfo: flightInfo)
                            }
                        }
                    }
                } else {
                    Text("데이터를 받아오는 데 실패하였습니다.")
                }
            }
            .navigationTitle(Text("즐겨찾기"))
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
