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
    
    func search(for country: String) async throws -> CountryModel? {
        
        do {
            let countryList =  try await searchRepo.fetchCountries()
                .map { CountryModel(name: $0.name, capital: $0.capital, flags: $0.flags, currencies: $0.currencies)}
            return countryList.first(where: { $0.name.lowercased() == country.lowercased()})
        } catch {
            throw error
        }
    }
}
