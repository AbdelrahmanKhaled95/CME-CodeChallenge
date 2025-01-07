//
//  SearchCountryUseCase.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import Foundation

class SearchCountryUseCase: SearchCountryUseCaseProtocol {
    
    private let searchRepo: SearchRepoProtocol
    
    init(searchRepo: SearchRepoProtocol) {
        self.searchRepo = searchRepo
    }
    
    func search() async throws -> [CountryModel] {
        
        do {
            let countryList =  try await searchRepo.fetchCountries()
            return countryList.map { CountryModel(name: $0.name, capital: $0.capital, flags: $0.flags, currencies: $0.currencies)}
        } catch {
            throw error
        }
    }
}
