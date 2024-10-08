//
//  FavoritesViewModel.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/11.
//

import SwiftUI
import Combine
import RealmSwift

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteInfos: Results<FavoritesEntity>?
    @Published var filteredFavoriteInfos: Results<FavoritesEntity>?
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedDepartAirport: String?
    @Published var selectedAirline: String?
    @Published var airportList: [String] = ["전체"]
    @Published var airlineList: [String] = ["전체"]
    private var token: NotificationToken?
    private let database = DataBaseManager.shared
    
    init() {
        self.selectedDepartAirport = "전체"
        self.selectedAirline = "전체"
        loadData()
        //즐겨찾기가 추가되는것 감지해서 데이터를 다시 로드합니다.
        token = favoriteInfos?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.loadData()
            case .update(_, let deletions, let insertions, let modifications):
                if !deletions.isEmpty || !insertions.isEmpty || !modifications.isEmpty {
                    self?.loadData()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
        
        $selectedDepartAirport
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.filterFavorites()
            }
            .store(in: &cancellables)
        
        $selectedAirline
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.filterFavorites()
            }
            .store(in: &cancellables)
    }
    
    func loadData() {
        favoriteInfos = database.read(FavoritesEntity.self)
        dropdownList()
    }
    
    deinit {
        token?.invalidate()
    }
    
    func dropdownList() {
        if !(favoriteInfos?.isEmpty ?? false) {
            airlineList = ["전체"]
            airportList = ["전체"]
            favoriteInfos?.forEach {
                if !(airlineList.contains($0.airlineNm)) {
                    airlineList.append($0.airlineNm)
                }
                if !(airportList.contains($0.depAirportNm)) {
                    airportList.append($0.depAirportNm)
                }
            }
        } else {
            airlineList = ["전체"]
            airportList = ["전체"]
        }
    }
    
    func filterFavorites() {
        let baseQuery = database.read(FavoritesEntity.self)
        filteredFavoriteInfos = baseQuery
        
        if let selectedDepartAirport = selectedDepartAirport, selectedDepartAirport != "전체" {
            filteredFavoriteInfos = baseQuery.filter("depAirportNm == %@", selectedDepartAirport)
        }
        
        if let selectedAirline = selectedAirline, selectedAirline != "전체" {
            filteredFavoriteInfos = filteredFavoriteInfos?.filter("airlineNm == %@", selectedAirline)
        }
    }
    
    
    
}
