//
//  ListView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/06.
//

import SwiftUI

struct flightRow: View {
    var flightInfo: FlightOpratInfo
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(flightInfo.depAirportNm) -> \(flightInfo.arrAirportNm) (\(flightInfo.airlineNm))" )
            HStack {
                Text("출발일:" + (String(flightInfo.depPlandTime).toDate()?.formatted("yyyy/MM/dd") ?? ""))
                Text("출발시간:" + (String(flightInfo.depPlandTime).toDate()?.formatted(date: .omitted, time: .shortened) ?? ""))
            }
            HStack {
                Text("도착일:" + (String(flightInfo.arrPlandTime).toDate()?.formatted("yyyy/MM/dd") ?? ""))
                Text("도착시간:" + (String(flightInfo.arrPlandTime).toDate()?.formatted(date: .omitted, time: .shortened) ?? ""))
            }
        }
    }
}

struct ListView: View {
    @Binding var flightInfos: [FlightOpratInfo]
    var body: some View {
        if flightInfos.isEmpty {
            Text("해당하는 일정의 항공 운항정보가 없습니다")
        }
        else {
            List {
                ForEach(flightInfos, id: \.self) { flightInfo in
                    flightRow(flightInfo: flightInfo)
                }
            }
        }

    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView(flightInfos: Binding<[FlightOpratInfo(airlineNm: "아시아나", arrAirportNm: "제주", arrPlandTime: 202309071045, depAirportNm: "광주", depPlandTime: 202309070955, economyCharge: 57000, prestigeCharge: 0, vihicleId: "OZ8141")]>)
//    }
//}
