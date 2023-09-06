//
//  APIService.swift
//  flight-information
//
//  Created by 이다연 on 2023/09/05.
//

import Foundation
import Combine
import Alamofire
 
// 1. Error 타입 정의
enum APIError: Error {
    case http(ErrorData)
    case unknown
}
 
// 2. ErrorData 안에 들어갈 정보 선언
struct ErrorData: Codable {
    var statusCode: Int
    var message: String
    var error: String?
}

enum API{
    case getFlightOpratInfoList
    case getArprtList
    case getAirmanList
    
    var url: URL{
        
        switch self {
        case .getFlightOpratInfoList: return URL(string: "http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList?serviceKey=" + String(Bundle.main.FLIGHT_API_KEY) + "&pageNo=1&numOfRows=10000&_type=json&depAirportId=NAARKJJ&arrAirportId=NAARKPC&depPlandTime=20230403&airlineId=AAR")!
        
        case .getArprtList: return URL(string: "http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList?serviceKey=" + String(Bundle.main.FLIGHT_API_KEY) + "&_type=json")!
            
        case .getAirmanList: return URL(string: "http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getAirmanList?serviceKey=" + String(Bundle.main.FLIGHT_API_KEY) + "&_type=json")!
        }
    }
}

enum ApiService {
    
    ///  항공운항정보 목록 가져오기
    /// - Returns: AnyPublisher<ArprtListResponse, Error>
    static func getFlightOpratInfoList() -> AnyPublisher<FlightOpratInfoListResponse , Error> {
        return AF.request(API.getFlightOpratInfoList.url)
            .publishDecodable(type: FlightOpratInfoListResponse.self) //디코딩
            .value() // 값만 가져오기
            .mapError { (afError:AFError) in
                //.value를 거치면 AnyPublisher<Value, AFError> 상태이므로 AFError -> Error로 캐스팅
                return afError as Error
            }
            .eraseToAnyPublisher()
    }
    
    ///  공항 목록 가져오기
    /// - Returns: AnyPublisher<ArprtListResponse, Error>
    static func getArprtList() -> AnyPublisher<ArprtListResponse , Error> {
        return AF.request(API.getArprtList.url)
            .publishDecodable(type: ArprtListResponse.self) //디코딩
            .value() // 값만 가져오기
            .mapError { (afError:AFError) in
                //.value를 거치면 AnyPublisher<Value, AFError> 상태이므로 AFError -> Error로 캐스팅
                return afError as Error
            }
            .eraseToAnyPublisher()
    }
    
    ///  항공사 목록 가져오기
    /// - Returns: AnyPublisher<AirmanListResponse, Error>
    static func getAirmanList() -> AnyPublisher<AirmanListResponse , Error> {
        return AF.request(API.getAirmanList.url)
            .publishDecodable(type: AirmanListResponse.self) //디코딩
            .value() // 값만 가져오기
            .mapError { (afError:AFError) in
                //.value를 거치면 AnyPublisher<Value, AFError> 상태이므로 AFError -> Error로 캐스팅
                return afError as Error
            }
            .eraseToAnyPublisher()
    }
}
 
