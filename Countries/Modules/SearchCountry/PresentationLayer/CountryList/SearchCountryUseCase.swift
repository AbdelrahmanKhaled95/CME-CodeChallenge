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

    
    //MARK: - Methods
    func cached() -> [CountryModel] {
        
        let countryList = searchRepo.fetchCachedCountries()
        return countryList.map({ countryModelDTO($0) })
    }
    
    func deleteCachedCountry(_ country: CountryModel) {
        
        searchRepo.deleteCashedCountry(countryEntityDTO(country))
    }
    
    func search(for country: String) async throws -> CountryModel? {
        
        do {
            let country = try await searchRepo.fetchCountries(for: country)
            return countryModelDTO(country)
        } catch {
            throw error
        }
    }
    
    private func countryModelDTO(_ country: CountryEntity?) -> CountryModel {
        
        return CountryModel(name: country?.name,
                            capital: country?.capital,
                            flag: country?.flags.png,
                            currencyCode: country?.currencies?.first?.code,
                            currencyName: country?.currencies?.first?.name,
                            currencySymbol: country?.currencies?.first?.symbol)
    }
    
    private func countryEntityDTO(_ country: CountryModel) -> CountryEntity {
        
        return CountryEntity(name: country.name ?? "", capital: country.capital ?? "", flags: Flags(png: country.flag ?? ""), currencies: [Currency(code: country.currencyCode ?? "", name: country.currencyName ?? "", symbol: country.currencySymbol ?? "")])
    }
}
