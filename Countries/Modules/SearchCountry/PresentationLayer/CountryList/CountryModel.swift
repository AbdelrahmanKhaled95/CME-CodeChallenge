//
//  CountryModel.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

// MARK: - CountryModel
struct CountryModel {
    
    let name: String
    let capital: String?
    let flags: Flags
    let currencies: [Currency]?
}

// MARK: - Currency
struct CurrencyModel {
    let code, name, symbol: String
}

// MARK: - Flags
struct FlagsModel {
    let png: String
}
