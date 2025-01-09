//
//  SearchRepoProtocol.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

protocol SearchRepoProtocol {
    
    func fetchCachedCountries() -> [CountryEntity]
    func deleteCashedCountry(_ country: CountryEntity)
    func fetchCountries(for country: String) async throws -> CountryEntity?
}
