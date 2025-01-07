//
//  SearchCountryUseCaseProtocol.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

protocol SearchCountryUseCaseProtocol {
    
    func searchCountry() async throws -> [Country]
}
