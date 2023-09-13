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
    @Published var fliteredFavoriteInfos: Results<FavoritesEntity>?
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
        token = favoriteInfos?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self?.loadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                if !deletions.isEmpty || !insertions.isEmpty || !modifications.isEmpty {
                    self?.loadData()
                }
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
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
        print("loadData")
        favoriteInfos = database.read(FavoritesEntity.self)
        dropdownList()
        // Set a notification to update the dropdown list whenever the data changes
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
        if (selectedDepartAirport != "전체" && selectedAirline != "전체") {
            fliteredFavoriteInfos = database.read(FavoritesEntity.self).filter("depAirportNm == '\(selectedDepartAirport ?? "")' AND airlineNm == '\(selectedAirline ?? "")'")
        } else if(selectedDepartAirport != "전체" && selectedAirline == "전체") {
            fliteredFavoriteInfos = database.read(FavoritesEntity.self).filter("depAirportNm == '\(selectedDepartAirport ?? "")'")
        } else if(selectedDepartAirport == "전체" && selectedAirline != "전체") {
            fliteredFavoriteInfos = database.read(FavoritesEntity.self).filter("airlineNm == '\(selectedAirline ?? "")'")
        } else {
            fliteredFavoriteInfos = database.read(FavoritesEntity.self)
        }
    }
    
    
    
}
