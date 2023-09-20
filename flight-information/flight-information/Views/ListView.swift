//
//  ListView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/06.
//

import SwiftUI


struct flightRow: View {
    var flightInfo: FlightOpratInfo
    @StateObject var flightRowModel:FlightRowModel = FlightRowModel()
    @State var isFavorite:Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(flightInfo.depAirportNm) -> \(flightInfo.arrAirportNm) (\(flightInfo.airlineNm))" )
                    .font(.system(size: 15))
                HStack {
                    Text("출발일:" + (String(flightInfo.depPlandTime).toDate()?.formatted("yyyy/MM/dd") ?? ""))
                        .font(.system(size: 15))
                    Text("출발시간:" + (String(flightInfo.depPlandTime).toDate()?.formatted(date: .omitted, time: .shortened) ?? ""))
                        .font(.system(size: 15))
                }
                HStack {
                    Text("도착일:" + (String(flightInfo.arrPlandTime).toDate()?.formatted("yyyy/MM/dd") ?? ""))
                        .font(.system(size: 15))
                    Text("도착시간:" + (String(flightInfo.arrPlandTime).toDate()?.formatted(date: .omitted, time: .shortened) ?? ""))
                        .font(.system(size: 15))
                }
            }
            .contentShape(Rectangle())
            Spacer()
            Button(action:{
                print("즐겨찾기")
                if (isFavorite) {
                    flightRowModel.deleteFavorites(flightInfo: flightInfo)
                    isFavorite = false
                } else {
                    flightRowModel.addFavorites(flightInfo: flightInfo)
                    isFavorite = true
                }
            }){
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(isFavorite == true ? .yellow : .gray)
            }.buttonStyle(BorderlessButtonStyle())
        }
        .onAppear {
            isFavorite = self.flightRowModel.checkFavorite(flightInfo: flightInfo)
        }
    }
}


struct ListView: View {
    @Binding var flightInfos: [FlightOpratInfo]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack{
                if flightInfos.isEmpty {
                    Text("해당하는 일정의 항공 운항정보가 없습니다")
                }
                else {
                    List(flightInfos, id: \.self) { flightInfo in
                        NavigationLink(destination: FlightDetailView(flightInfo: flightInfo)) {
                            flightRow(flightInfo: flightInfo)
                        }
                    }
                }
            }
            .toolbarBackground(
                Color.gray,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark").imageScale(.large).foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    @State static var value = [FlightOpratInfo(airlineNm: "아시아나", arrAirportNm: "제주", arrPlandTime: 202309071045, depAirportNm: "광주", depPlandTime: 202309070955, economyCharge: 57000, prestigeCharge: 0, vihicleId: "OZ8141")]
    static var previews: some View {
        ListView(flightInfos: $value)
    }
}
