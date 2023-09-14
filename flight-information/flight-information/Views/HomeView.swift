//
//  HomeView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI
import AlertToast

struct HomeView: View {
    @ObservedObject var homeViewModel:HomeViewModel = HomeViewModel()
    @State var loading = false
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Text("출발공항")
                DropdownView(selected: $homeViewModel.selectedDepartAirport,
                             list: $homeViewModel.airportList) { airport in
                    "\(airport.airportNm)"
                }contentAppearance: { airport in
                    Text("\(airport.airportNm)")
                }.frame(width: 250)
                    .toast(isPresenting: $loading) {
                        AlertToast(type: .loading)
                    }
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
                    loading.toggle()
                    self.homeViewModel.flightOpratInfo()
                    homeViewModel.isSameAirPort()
                }, label: {
                    HStack {
                        Text("검색")
                    }
                    .fixedSize()
                })
                .buttonStyle(.borderedProminent)
                .disabled((self.homeViewModel.selectedArriveAirport == nil || self.homeViewModel.selectedDepartAirport == nil || self.homeViewModel.selectedAirline == nil) || loading)
                
                .alert(isPresented: $homeViewModel.sameAirportAlert) {
                    Alert(title: Text("출발공항과 도착공항을 다르게 설정해주세요."), message: nil,
                          dismissButton: .default(Text("확인")))
                }
                
                .popover(isPresented: $homeViewModel.isFinished) {
                    ListView(flightInfos: $homeViewModel.flightInfo)
                        .onDisappear {
                            loading.toggle()
                        }
                }
            }
            .navigationBarTitle(Text("항공운항정보 조회"))
        }
        
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
