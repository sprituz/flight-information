# FlyInfo





---

> 국내선 항공운항정보 조회 및 즐겨찾기가 가능한 애플리케이션입니다. </br>

## 목차

- [project](#project)
  - [목차](#목차)
  - [핵심 기능](#핵심-기능)
  - [폴더 구조도](#폴더-구조도)
  - [설치 및 실행 방법](#설치-및-실행-방법)
  - [사용한 기술](#사용한-기술)
  - [주요 이슈](#주요-이슈)
  - [라이센스](#라이센스)

## 핵심 기능

국토교통부에서 제공하는 국내항공운항정보 API 연동으로 실시간 데이터를 조회할 수 있습니다.

| 운항정보 검색 | 운항 상세정보 제공 | 즐겨찾기 기능 |
|:--------------:|:------------------:|:-------------:|
|<img src="https://github.com/user-attachments/assets/2fc2aef9-0c79-4a30-a157-49b48b4752ed" width="300"/>|<img src="https://github.com/user-attachments/assets/ea4bd91e-29b1-473d-96fb-e7e8ebf7cbe9" width="300"/>|<img src="https://github.com/user-attachments/assets/d2ba53be-ffbe-4c0e-adc4-56bcb77cfbdf" width="300"/>|
|출발, 도착 공항, 항공사, 출발 일자로 <br>운항정보를 검색할 수 있습니다.|해당 항공편의 운항 상세 정보를 <br>확인할 수 있습니다.|출발 공항별, 항공사별 즐겨찾기 조회가 가능합니다.|


## 폴더 구조도

```
.
├── flight-information
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   ├── AppIcon~ios-marketing.png
│   │   │   └── Contents.json
│   │   └── Contents.json
│   ├── Extensions
│   │   ├── Binding+.swift
│   │   ├── Date+.swift
│   │   ├── Int+.swift
│   │   ├── String+.swift
│   │   └── flight-information++Bundle.swift
│   ├── FlightInfo.plist
│   ├── Info.plist
│   ├── Managers
│   │   └── DataBaseManager.swift
│   ├── Models
│   │   ├── AirlineEntity.swift
│   │   ├── AirmanListResponse.swift
│   │   ├── AirportEntity.swift
│   │   ├── ArprtListResponse.swift
│   │   ├── FavoritesEntity.swift
│   │   └── FlightOpratInfoListResponse.swift
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Services
│   │   └── APIService.swift
│   ├── ViewModels
│   │   ├── FavoritesViewModel.swift
│   │   ├── FlightRowModel.swift
│   │   └── HomeViewModel.swift
│   ├── Views
│   │   ├── DropdownView.swift
│   │   ├── FavoritesView.swift
│   │   ├── FlightDetailView.swift
│   │   ├── HomeView.swift
│   │   ├── ListView.swift
│   │   └── RootView.swift
│   └── flight_informationApp.swift
├── flight-information.xcodeproj
├── flight-informationTests
│   └── flight_informationTests.swift
└── flight-informationUITests
    ├── flight_informationUITests.swift
    └── flight_informationUITestsLaunchTests.swift
```

## 설치 및 실행 방법


아래 링크에서 해당 API 활용 신청이 필요합니다.

[**국내항공운항정보 활용신청**](https://www.data.go.kr/data/15098526/openapi.do)

활용 신청 완료 후 info.plist와 동일한 경로에 FlightInfo.plist 라는 이름으로 파일을 생성해주세요.

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>FLIGHT_API_KEY</key>
    <string>본인의 API key</string>
    </dict>
    </plist>

key는 FLIGHT_API_KEY, 값은 본인의 API key 를 넣어주세요.

위 과정을 완료한 후 프로젝트를 클론합니다:

    git clone https://github.com/sprituz/flight-information.git
    cd flight-information

.xcworkspace 파일을 열고 프로젝트를 빌드합니다:



## 사용한 기술

- SwiftUI & Combine
    - SwiftUI를 이용하여 UI 구성
    - Combine 을 이용하여 데이터 바인딩
- MVVM
    - 로직과 view를 분리
- Realm
    - 즐겨찾기 데이터 저장
- Alamofire
    - 간편하게 HTTP 통신



## 주요 이슈

<!-- 핵심 트러블 슈팅 & 주요 이슈-->
<!-- 그외 트러블 슈팅 & 주요 이슈-->

## 라이센스

Apache 2.0
