//
//  String+.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/07.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        return dateFormatter.date(from: self)
    }
}

