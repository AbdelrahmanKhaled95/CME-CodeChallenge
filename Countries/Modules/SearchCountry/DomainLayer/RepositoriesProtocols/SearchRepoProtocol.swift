//
//  SearchRepoProtocol.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

protocol SearchRepoProtocol {
    
    func fetchCountries() async throws -> [Country]
}
