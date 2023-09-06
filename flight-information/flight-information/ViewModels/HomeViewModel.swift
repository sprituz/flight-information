//
//  HomeViewModel.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var flightInfo: [FlightOpratInfo] = []
    @Published var selectedDepartAirport: Airport? = nil
    @Published var selectedArriveAirport: Airport? = nil
    @Published var selectedAirline: Airline? = nil
    @Published var selectedDate: Date = Date()
    @Published var airportList: [Airport] = []
    @Published var airlineList: [Airline] = []

    
    func getFlightOpratInfoList(){
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyyMMdd"
        let convertDateStr = myDateFormatter.string(from: selectedDate) // 선택된 시간의 Date를 format에 맞춰 string으로 반환
        ApiService.getFlightOpratInfoList(depAirportId: selectedDepartAirport?.airportId ?? "", arrAirportId: selectedArriveAirport?.airportId ?? "", depPlandTime: convertDateStr, airlineId: selectedAirline?.airlineId ?? "")
            .sink { completion in
                
                switch completion {
                case .failure(let err):
                    print("\(err)")
                case .finished:
                    print("get flight info Finish")
                }
                
            } receiveValue: { (response: FlightOpratInfoListResponse) in
                print(response.response.body.items.item)
                self.flightInfo = response.response.body.items.item
            }.store(in: &subscriptions)
        
    }
    
    func getAirportList() {
        ApiService.getArprtList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("airport completion: \(completion)")
            } receiveValue: { airportListResponse in
                let airportList = airportListResponse.response.body.items.item
                self.airportList = airportList
            }
            .store(in: &subscriptions)
    }
    
    func getAirlineList() {
        ApiService.getAirmanList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("airline completion: \(completion)")
            } receiveValue: { airlineListResponse in
                let airlineList = airlineListResponse.response.body.items.item
                self.airlineList = airlineList
            }
            .store(in: &subscriptions)
    }
    
}

