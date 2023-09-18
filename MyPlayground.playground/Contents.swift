import UIKit

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 한국어로 설정
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

let dateString = "202309180610"
if let date = dateString.convertToDate() {
    print(date.formatted("yyyy년 M월 dd일 a hh:mm")) // 출력: 2023년 9월 18일 오전 06:10
}
