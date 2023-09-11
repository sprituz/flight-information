//
//  HomeViewModel.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI
import Combine
import RealmSwift

class HomeViewModel: ObservableObject {
    
    @Published var airlines: Results<AirlineEntity>?
    @Published var airports: Results<AirportEntity>?
    private var token: NotificationToken?
    var subscriptions = Set<AnyCancellable>()
    @Published var flightInfo: [FlightOpratInfo] = []
    @Published var selectedDepartAirport: Airport? = nil
    @Published var selectedArriveAirport: Airport? = nil
    @Published var selectedAirline: Airline? = nil
    @Published var selectedDate: Date = Date()
    @Published var airportList: [Airport] = []
    @Published var airlineList: [Airline] = []
    @Published var isFinished: Bool = false
    
    init() {
            loadData()
        }

        func loadData() {
            let realm = try! Realm()
            airlines = realm.objects(AirlineEntity.self)
            airports = realm.objects(AirportEntity.self)

            // Set a notification to update the UI whenever the data changes
            token = airlines?.observe { [weak self] _ in
                self?.objectWillChange.send()
            }
            
            // Check if data is empty and fetch if needed
            if airports?.isEmpty ?? true {
                getAirportList()
            }
            if airlines?.isEmpty ?? true {
                getAirlineList()
            }
        }

       deinit {
           token?.invalidate()
       }

    
    func getFlightOpratInfoList(){
        ApiService.getFlightOpratInfoList(depAirportId: selectedDepartAirport?.airportId ?? "", arrAirportId: selectedArriveAirport?.airportId ?? "", depPlandTime: selectedDate.formatted("yyyyMMdd"), airlineId: selectedAirline?.airlineId ?? "")
            .sink { completion in
                
                switch completion {
                case .failure(let err):
                    print("\(err)")
                    self.flightInfo = []
                    self.isFinished = false
                case .finished:
                    print("get flight info Finish")
                    self.isFinished = true
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

