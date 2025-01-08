//
//  FakeSearchUseCase.swift
//  CountriesTests
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

@testable import Countries

class FakeSearchUseCase: SearchCountryUseCaseProtocol {
    
    //MARK: - Properties
    var isEmptyCache: Bool = false
    var countryCached: Bool = false
    var countryCachedDeleted: Bool = false
    var searched: Bool = false
    var isValidCountry: Bool = false
    
    init(isEmptyCache: Bool, isValidCountry: Bool = false) {
        
        self.isEmptyCache = isEmptyCache
        self.isValidCountry = isValidCountry
    }
    
    func cached() -> [Countries.CountryModel] {
        
        countryCached = true
        return isEmptyCache ? [] : [DummyData.country]
    }
    
    func deleteCachedCountry(_ country: Countries.CountryModel) {
        countryCachedDeleted = true
    }
    
    func search(for country: String) async throws -> Countries.CountryModel? {
        searched = true
        return isValidCountry ? DummyData.country : nil
    }
}
