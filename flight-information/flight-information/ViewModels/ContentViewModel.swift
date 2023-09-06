//
//  ContentViewModel.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/06.
//
import Combine

class ContentViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    @Published var airlines: [Airline] = []
    @Published var airports: [Airport] = []
    
    func getArprtList(){
        ApiService.getArprtList()
            .sink { completion in
                
                switch completion {
                case .failure(let err):
                    print("\(err)")
                case .finished:
                    print("Finish")
                }
                
            } receiveValue: { (response: ArprtListResponse) in
                print(response.response.body.items)
                self.airports = response.response.body.items.item
            }.store(in: &subscriptions)
        
    }
    
    func getAirmanList(){
        ApiService.getAirmanList()
            .sink { completion in
                
                switch completion {
                case .failure(let err):
                    print("\(err)")
                case .finished:
                    print("Finish")
                }
                
            } receiveValue: { (response: AirmanListResponse) in
                print(response.response.body.items.item)
                self.airlines = response.response.body.items.item
            }.store(in: &subscriptions)
        
    }
}
