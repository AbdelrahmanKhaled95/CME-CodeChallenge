//
//  SearchCountryUseCaseProtocol.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

protocol SearchCountryUseCaseProtocol {
    
    func search(for country: String) async throws -> CountryModel?
}
