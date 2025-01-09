//
//  SearchConfiguration.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//


enum SearchConfiguration {
    
    case fetchCountry
    
    var path: String {
        switch self {
        case .fetchCountry:
            return APIEndPoint.searchCountry.rawValue
        }
    }
}
