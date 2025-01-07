//
//  Country.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

// MARK: - Country
struct Country: Codable {
    let name: String
    let capital: String?
    let flags: Flags
    let currencies: [Currency]?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
}
