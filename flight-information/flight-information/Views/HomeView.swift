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
                print(self.homeViewModel.selectedArriveAirport)
                print(self.homeViewModel.selectedDepartAirport)
                print(self.homeViewModel.selectedDate.description)
                print(self.homeViewModel.selectedAirline)
            }, label: {
                HStack {
                    Text("조회")
                }
                .fixedSize()
            })
            .buttonStyle(.borderedProminent)
            .disabled(self.homeViewModel.selectedArriveAirport == nil || self.homeViewModel.selectedDepartAirport == nil || self.homeViewModel.selectedAirline == nil)
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
