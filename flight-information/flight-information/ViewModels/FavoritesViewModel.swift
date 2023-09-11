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
    private var token: NotificationToken?
    private let database = DataBaseManager.shared
    
    init() {
        loadData()
    }
    func loadData() {
        let realm = try! Realm()
        favoriteInfos = realm.objects(FavoritesEntity.self)

        // Set a notification to update the UI whenever the data changes
        token = favoriteInfos?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
        
        // Check if data is empty and fetch if needed
        if favoriteInfos?.isEmpty ?? true {
            getFavoriteInfos()
        }
    }

   deinit {
       token?.invalidate()
   }

    func getFavoriteInfos(){
        favoriteInfos = database.read(FavoritesEntity.self)
    }
    
}
