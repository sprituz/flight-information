//
//  ContentView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import SwiftUI

struct ContentView: View{
    @StateObject var contentViewModel:ContentViewModel
    @State var value = ""
    @Binding var dropDownFor:String
    var placeholder = "선택해주세요"
    
    init(){
        self._contentViewModel = StateObject.init(wrappedValue: ContentViewModel())
        //StateObject는  _(언더바)를 붙혀서 초기화를 해줘야함, bind과 같음
    }
    
    var body: some View {
        Menu {
            if airports != nil {
                ForEach(airports, id: \.self){ airport in
                    Button(airport.airportNm) {
                        self.value = airport.airportId
                    }
                }
            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    Text(value.isEmpty ? placeholder : value)
                        .foregroundColor(value.isEmpty ? .white : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 20, weight: .bold))
                }
                .padding(.horizontal)
            }.frame(width: 200, height:30)
        }.background(Color.gray)
            .onAppear()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(arr:[])
//    }
//}
