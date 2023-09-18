//
//  Date+.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import Foundation

extension Date {
    
    /**
     # formatted
     - Parameters:
     - format: 변형할 DateFormat
     - Note: DateFormat으로 변형한 String 반환
     */
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 한국어로 설정
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
