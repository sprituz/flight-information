//
//  HomeView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI
import AlertToast

struct HomeView: View {
    @StateObject var homeViewModel:HomeViewModel = HomeViewModel()
    @State var loading = false
    @State private var calendarId: Int = 0
    let date = Calendar.current.date(byAdding: .month, value: 1, to: Date())
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Text("출발공항")
                DropdownView(selected: $homeViewModel.selectedDepartAirport,
                             list: $homeViewModel.airportList) { airport in
                    "\(airport.airportNm)"
                }contentAppearance: { airport in
                    Text("\(airport.airportNm)")
                }
                .frame(width: 250, height: 40)
                .toast(isPresenting: $loading) {
                    AlertToast(type: .loading)
                }
                Text("도착공항")
                DropdownView(selected: $homeViewModel.selectedArriveAirport,
                             list: $homeViewModel.airportList) { airport in
                    "\(airport.airportNm)"
                }contentAppearance: { airport in
                    Text("\(airport.airportNm)")
                }
                .frame(width: 250, height: 40)
                DatePicker(
                    "출발일",
                    selection: $homeViewModel.selectedDate,
                    in: Date()...(date ?? Date()),
                    displayedComponents: [.date]
                )
                .frame(width: 250, height: 40)
                .id(calendarId)
                .onChange(of: homeViewModel.selectedDate, perform: { _ in
                    calendarId += 1
                })
                .frame(width: 250, height: 40)
                Text("항공사")
                DropdownView(selected: $homeViewModel.selectedAirline,
                             list: $homeViewModel.airlineList) { airline in
                    "\(airline.airlineNm)"
                }contentAppearance: { airline in
                    Text("\(airline.airlineNm)")
                }
                .frame(width: 250, height: 40)
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
                          dismissButton: .default(Text("확인")) {loading.toggle()})
                }
                .popover(isPresented: $homeViewModel.isFinished) {
                    ListView(flightInfos: $homeViewModel.flightInfo)
                        .onDisappear {
                            loading.toggle()
                        }
                }
            }
            .navigationBarTitle("항공운항정보 조회")
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
