//
//  Binding+.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/13.
//
import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
