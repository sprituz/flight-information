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
        VStack(spacing: 15){
            Text("항공편명: \(flightInfo.vihicleId)")
            Text("항공사명: \(flightInfo.airlineNm)")
            HStack {
                Text("출발일:" + (String(flightInfo.depPlandTime).toDate()?.formatted("yyyy/MM/dd") ?? ""))
                Text("출발시간:" + (String(flightInfo.depPlandTime).toDate()?.formatted(date: .omitted, time: .shortened) ?? ""))
            }
            HStack {
                Text("도착일:" + (String(flightInfo.arrPlandTime).toDate()?.formatted("yyyy/MM/dd") ?? ""))
                Text("도착시간:" + (String(flightInfo.arrPlandTime).toDate()?.formatted(date: .omitted, time: .shortened) ?? ""))
            }
            Text("일반석운임: \(flightInfo.economyCharge)원")
            Text("비즈니스석운임: \(flightInfo.prestigeCharge == 0 ? "미운영": flightInfo.prestigeCharge.withCommas()+"원")")
            
            Text("출발공항: \(flightInfo.depAirportNm)공항")
            Text("도착공항: \(flightInfo.arrAirportNm)공항")
        }
    }
}

struct FlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailView(flightInfo: FlightOpratInfo(airlineNm: "아시아나항공", arrAirportNm: "제주", arrPlandTime: 202309081045, depAirportNm: "광주", depPlandTime: 202309080955, economyCharge: 57900, prestigeCharge: 0, vihicleId: "OZ8141"))
    }
}
