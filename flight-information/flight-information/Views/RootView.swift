//
//  RootView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI

struct RootView: View {
    @State private var selectedIndex: Int = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .tabItem({
                    Image(systemName: "house.fill")
                    Text("Home")
                })
                .tag(0)
            FavoritesView()
                .tabItem({
                    Image(systemName: "star.fill")
                    Text("Favorite")
                })
                .tag(1)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
