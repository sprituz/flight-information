//
//  HomeView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel:HomeViewModel = HomeViewModel()
    @State private var searchText: String = ""
    @State private var dropDownFor: String = ""
    @State private var sameAirportAlert = false
    init(){
    }
    
    var body: some View {
        VStack(spacing: 10){
            Text("출발공항")
            
            DropdownView(selected: $homeViewModel.selectedDepartAirport,
                         list: $homeViewModel.airportList) { airport in
                "\(airport.airportNm)"
            }contentAppearance: { airport in
                Text("\(airport.airportNm)")
            }.frame(width: 250)
            
            Text("도착공항")
            
            DropdownView(selected: $homeViewModel.selectedArriveAirport,
                         list: $homeViewModel.airportList) { airport in
                "\(airport.airportNm)"
            }contentAppearance: { airport in
                Text("\(airport.airportNm)")
            }.frame(width: 250)
            
            DatePicker(
                "출발일",
                selection: $homeViewModel.selectedDate,
                displayedComponents: [.date]
            ).frame(width: 200)
            
            Text("항공사")
            DropdownView(selected: $homeViewModel.selectedAirline,
                         list: $homeViewModel.airlineList) { airline in
                "\(airline.airlineNm)"
            }contentAppearance: { airline in
                Text("\(airline.airlineNm)")
            }.frame(width: 250)
            
            Button(action: {
                print("조회")
                self.homeViewModel.getFlightOpratInfoList()
                if (self.homeViewModel.selectedArriveAirport?.airportId == self.homeViewModel.selectedDepartAirport?.airportId) {
                    sameAirportAlert = true
                }
            }, label: {
                HStack {
                    Text("조회")
                }
                .fixedSize()
            })
            .buttonStyle(.borderedProminent)
            .disabled(self.homeViewModel.selectedArriveAirport == nil || self.homeViewModel.selectedDepartAirport == nil || self.homeViewModel.selectedAirline == nil)
            
//            .alert(isPresented: $noFlightAlert) {
//                Alert(title: Text("해당 일정의 항공운항정보가 없습니다"), message: nil,
//                      dismissButton: .default(Text("확인")))
//            }
            
            .alert(isPresented: $sameAirportAlert) {
                Alert(title: Text("출발공항과 도착공항을 다르게 설정해주세요."), message: nil,
                      dismissButton: .default(Text("확인")))
            }
            ListView(flightInfos: $homeViewModel.flightInfo)
        }
        .onAppear{
            self.homeViewModel.getAirportList()
            self.homeViewModel.getAirlineList()
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
