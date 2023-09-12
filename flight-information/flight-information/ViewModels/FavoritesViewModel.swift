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
        favoriteInfos = database.read(FavoritesEntity.self)
        // Set a notification to update the UI whenever the data changes
        token = favoriteInfos?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

   deinit {
       token?.invalidate()
   }
    

    
}
