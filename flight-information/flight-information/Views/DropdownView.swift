//
//  DropdownView.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/06.
//

import SwiftUI

struct DropdownView<T: Hashable, V: View>: View {
    @Binding var selected: T?
    @Binding var list: [T]
    var contentAppearance: ((T) -> V)
    var contentToText: ((T)->String)
    
    init(selected: Binding<T?>,
         list: Binding<[T]>,
         contentToText: @escaping ((T)->String),
         contentAppearance: @escaping ((T) -> V)
    ){
        self._selected = selected
        self._list = list
        self.contentToText = contentToText
        self.contentAppearance = contentAppearance
    }
    
    var body: some View {
        Menu {
            ForEach(list, id: \.self){ content in
                Button {
                    self.selected = content
                } label: {
                    contentAppearance(content)
                }
            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    if let selected = selected {
                        Text(contentToText(selected))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 20, weight: .bold))
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
        }
        .cornerRadius(16)
        .overlay (RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 1)
            .foregroundColor(.gray.opacity(0.7))
            .frame(height: 35)
        )
        .padding(.horizontal)
    }
}
