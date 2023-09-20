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
    @Published var sameAirportAlert = false
    private let database = DataBaseManager.shared
    
    init() {
        loadData()
    }
    
    func loadData() {
        airlines = database.read(AirlineEntity.self)
        airports = database.read(AirportEntity.self)
        // 데이터 바뀔때 UI update
        token = airlines?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
        
        token = airports?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
        
        airlineList = Array(airlines!).map {Airline(airlineId: $0.airlineId, airlineNm: $0.airlineNm!) }
        airportList = Array(airports!).map {Airport(airportId: $0.airportId, airportNm: $0.airportNm!) }
        
        if airlineList.isEmpty {
            print("airlines empty")
            airline()
        }
        
        if airportList.isEmpty {
            print("airports empty")
            airport()
        }
    }
    
    deinit {
        token?.invalidate()
    }
    
    
    func flightOpratInfo(){
        ApiService.getFlightOpratInfoList(depAirportId: selectedDepartAirport?.airportId ?? "", arrAirportId: selectedArriveAirport?.airportId ?? "", depPlandTime: selectedDate.formatted("yyyyMMdd"), airlineId: selectedAirline?.airlineId ?? "")
            .sink { completion in
                
                switch completion {
                case .failure(let err):
                    print("\(err)")
                    self.flightInfo = []
                    self.isFinished = true
                case .finished:
                    print("get flight info Finish")
                    self.isFinished = true
                }
                
            } receiveValue: { (response: FlightOpratInfoListResponse) in
                print(response.response.body.items.item)
                self.flightInfo = response.response.body.items.item
            }.store(in: &subscriptions)
        
    }
    
    func airport() {
        ApiService.getArprtList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("airport completion: \(completion)")
            } receiveValue: { airportListResponse in
                self.airportList = airportListResponse.response.body.items.item
                
                // API로부터 받아온 공항 목록과 현재 Realm에 저장된 공항 목록을 비교합니다.
                let newAirports = self.airportList.filter { apiAirport in
                    return self.airports?.first(where: { $0.airportId == apiAirport.airportId }) == nil
                }
                
                // 새로운 공항이 있다면, 이들을 Realm에 추가합니다.
                newAirports.forEach {
                    let task = AirportEntity(airportId: $0.airportId, airportNm: $0.airportNm)
                    self.database.write(task)
                }
                
                self.airportList = newAirports.isEmpty ? self.airportList : newAirports
            }
            .store(in: &subscriptions)
    }
    
    func airline() {
        ApiService.getAirmanList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("airline completion: \(completion)")
            } receiveValue: { airlineListResponse in
                self.airlineList = airlineListResponse.response.body.items.item
                
                // API로부터 받아온 공항 목록과 현재 Realm에 저장된 공항 목록을 비교합니다.
                let newAirlines = self.airlineList.filter { apiAirline in
                    return self.airlines?.first(where: { $0.airlineId == apiAirline.airlineId }) == nil
                }
                
                // 새로운 공항이 있다면, 이들을 Realm에 추가합니다.
                newAirlines.forEach {
                    let task = AirlineEntity(airlineId: $0.airlineId, airlineNm: $0.airlineNm)
                    self.database.write(task)
                }
                
                self.airlineList = newAirlines.isEmpty ? self.airlineList : newAirlines
            }
            .store(in: &subscriptions)
    }


    func isSameAirPort() {
        if (selectedDepartAirport == selectedArriveAirport) {
            sameAirportAlert = true
        } else {
            sameAirportAlert = false
        }
    }
    
}

