//
//  FlightDetailView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import SwiftUI

struct FlightDetailView: View {
    let flightInfo: FlightOpratInfo
    
    var body: some View {
        VStack{
            Text("항공편명")
            Text("항공사명")
            Text("출발시간")
            Text("도착시간")
            Text("일반석운임")
            Text("비즈니스석운임")
            Text("출발공항")
            Text("도착공항")
        }
    }
}

struct FlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailView(flightInfo: FlightOpratInfo(airlineNm: "아시아나항공", arrAirportNm: "제주", arrPlandTime: 202309081045, depAirportNm: "광주", depPlandTime: 202309080955, economyCharge: 57900, prestigeCharge: 0, vihicleId: "OZ8141"))
    }
}
