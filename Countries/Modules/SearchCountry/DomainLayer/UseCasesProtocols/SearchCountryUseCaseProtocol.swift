//
//  SearchCountryUseCaseProtocol.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

protocol SearchCountryUseCaseProtocol {
    
    func cached() -> [CountryModel]
    func deleteCachedCountry(_ country: CountryModel)
    func search(for country: String) async throws -> CountryModel?
}
