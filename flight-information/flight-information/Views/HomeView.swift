//
//  HomeView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel:HomeViewModel
    @State private var searchText: String = ""
    @State private var dropDownFor: String = ""
    @State var date = Date()
    
    init(){
        self._homeViewModel = StateObject.init(wrappedValue: HomeViewModel())
        
        //StateObject는  _(언더바)를 붙혀서 초기화를 해줘야함, bind과 같음
    }
    
    var body: some View {
        VStack{
            Text("출발공항")
            ContentView(dropDownFor: $dropDownFor)
            Text("도착공항")
            ContentView(dropDownFor: $dropDownFor)
            DatePicker(
                  "출발일",
                  selection: $date,
                  displayedComponents: [.date]
            ).frame(width: 200)
            Text("항공사")
            dropDownFor = "airport"
            ContentView(arr: self.homeViewModel.$airlines)
            Button(action: {
                print("검색")
            }, label: {
                HStack {
                    Text("검색")
                }
                .fixedSize()
            })
            .buttonStyle(.borderedProminent)
            Text(self.homeViewModel.airports.debugDescription)
        }
        .onAppear{
            self.homeViewModel.getFlightOpratInfoList()
            self.homeViewModel.getArprtList()
            self.homeViewModel.getAirmanList()
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
