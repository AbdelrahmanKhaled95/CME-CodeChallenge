//
//  CountryListError.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

enum CountryListError {
    
    case emptySearchField
    case fullList
    case duplicate
    case wrongName(String)
    case other(String)
    
    var message: String {
        
        switch self {
        case .emptySearchField:
            "Please enter a country to search"
        case .fullList:
            "Can't add more countries, Please remove atleast one"
        case .duplicate:
            "Country already exists. Please choose another"
        case let .wrongName(value):
            "No country with this name \(value) was found"
        case let .other(value):
            value
        }
    }
}
