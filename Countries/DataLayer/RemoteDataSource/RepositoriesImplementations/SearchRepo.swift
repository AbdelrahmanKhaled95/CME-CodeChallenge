//
//  SearchRepo.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

class SearchRepo {
    
    // MARK: - Properties
    let client: BaseAPIClient
    
    // MARK: - Init
    init() {
        client = BaseAPIClient(baseUrl: Environment.baseUrl)
    }
    
    // MARK: - Method
    func fetchCountries() async throws -> [Country] {
        try await client.performRequest(path: SearchConfiguration.fetchCountry.path)
    }
}
