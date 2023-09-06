//
//  flight-information++Bundle.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import Foundation

extension Bundle {
    var FLIGHT_API_KEY: String {
        guard let file = self.path(forResource: "FlightInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["FLIGHT_API_KEY"] as? String else {
            fatalError("FLIGHT_API_KEY error")
        }
        return key
    }
}
