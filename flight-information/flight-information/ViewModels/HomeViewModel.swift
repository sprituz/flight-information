//
//  HomeViewModel.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import Combine

class HomeViewModel: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    @Published var flightInfo: [FlightOpratInfo] = []

    func getFlightOpratInfoList(){
        ApiService.getFlightOpratInfoList()
            .sink { completion in
                
                switch completion {
                case .failure(let err):
                    print("\(err)")
                case .finished:
                    print("Finish")
                }
                
            } receiveValue: { (response: FlightOpratInfoListResponse) in
                print(response.response.body.items.item)
                self.flightInfo = response.response.body.items.item
            }.store(in: &subscriptions)
        
    }
    
}
