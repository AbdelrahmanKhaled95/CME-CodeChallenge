//
//  CountryDetailsViewModel.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

import Foundation

class CountryDetailsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var name: String?
    @Published var capital: String?
    @Published var flag: String?
    @Published var code: String?
    @Published var currencyName: String?
    @Published var symbol: String?
    
    // MARK: - Stored Properties
    private let country: CountryModel
    
    // MARK: - Init
    init(country: CountryModel) {
        self.country = country
        loadValues()
    }
    
    //MARK: -
    private func loadValues() {
        name = country.name
        capital = country.capital
        flag = country.flag
        code = country.currencyCode
        currencyName = country.currencyName
        symbol = country.currencySymbol
    }
}
