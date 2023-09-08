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
    
    var url: String{
        
        switch self {
        case .getFlightOpratInfoList: return "http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"
        
        case .getArprtList: return "http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList"
            
        case .getAirmanList: return "http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getAirmanList"
        }
    }
}

enum ApiService {
    
    ///  항공운항정보 목록 가져오기
    /// - Returns: AnyPublisher<ArprtListResponse, Error>
    static func getFlightOpratInfoList(depAirportId:String,
                                       arrAirportId: String,
                                       depPlandTime:String,
                                       airlineId: String) -> AnyPublisher<FlightOpratInfoListResponse , Error> {
        
        
        let newUrl = URL(string: API.getFlightOpratInfoList.url + "?serviceKey=\(Bundle.main.FLIGHT_API_KEY)&pageNo=1&numOfRows=10000&_type=json&depAirportId=\(depAirportId)&arrAirportId=\(arrAirportId)&depPlandTime=\(depPlandTime)&airlineId=\(airlineId)")!
        return AF.request(newUrl)
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
        let newUrl = URL(string: API.getArprtList.url + "?serviceKey=\(Bundle.main.FLIGHT_API_KEY)&_type=json")!
        return AF.request(newUrl)
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
        let newUrl = URL(string: API.getAirmanList.url + "?serviceKey=\(Bundle.main.FLIGHT_API_KEY)&_type=json")!
        return AF.request(newUrl)
            .publishDecodable(type: AirmanListResponse.self) //디코딩
            .value() // 값만 가져오기
            .mapError { (afError:AFError) in
                //.value를 거치면 AnyPublisher<Value, AFError> 상태이므로 AFError -> Error로 캐스팅
                return afError as Error
            }
            .eraseToAnyPublisher()
    }
}
 
