//
//  SearchRepo.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import CoreData

class SearchRepo: SearchRepoProtocol {
    
    // MARK: - Properties
    let client: BaseAPIClient
    private var viewContext = CoreDataStack.shared.viewContext
    
    // MARK: - Init
    init() {
        client = BaseAPIClient(baseUrl: Environment.baseUrl)
    }
    
    // MARK: - Method
    func fetchCachedCountries() -> [CountryEntity] {
        fetchCountries().map { countryDBToEntity($0) }
    }
    
    func deleteCashedCountry(_ country: CountryEntity) {
        fetchAndDeleteCountry(country)
    }
    
    func fetchCountries(for country: String) async throws -> CountryEntity? {
        
        do {
            
            let countryList: [CountryEntity] = try await client.performRequest(path: SearchConfiguration.fetchCountry.path)
            
            let country = countryList.first(where: { $0.name.lowercased() == country.lowercased()})
            
            saveCountry(country)
            return country
        } catch {
            throw error
        }
    }
}

//MARK: - Core Data
extension SearchRepo {
    
    private func saveCountry(_ country: CountryEntity?) {
        
        guard let country else { return }
        
        let countryDB = countryEntityToDB(country)

        do {
            try viewContext.save()
        } catch {
            print("Error saving person: \(error)")
        }
    }
    
    private func fetchCountries() -> [CountryDB] {
        let fetchRequest: NSFetchRequest<CountryDB> = CountryDB.fetchRequest()
        
        do {
           return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func fetchAndDeleteCountry(_ country: CountryEntity) {
        
        let fetchRequest: NSFetchRequest<CountryDB> = CountryDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", country.name)
        
        do {
            let countryDB = try viewContext.fetch(fetchRequest)
            
            if let countryToDelete = countryDB.first {
                viewContext.delete(countryToDelete)
                
                try viewContext.save()
                
            } else {
                print("No person found with the given name.")
            }
        } catch {
            print("Failed to fetch or delete the person: \(error)")
        }
    }
    
    private func countryEntityToDB(_ countryEntity: CountryEntity) -> CountryDB {
        
        let countryDB = CountryDB(context: viewContext)
        countryDB.name = countryEntity.name
        countryDB.capital = countryEntity.capital
        countryDB.flag = countryEntity.flags.png
        countryDB.currencyCode = countryEntity.currencies?.first?.code
        countryDB.currencyName = countryEntity.currencies?.first?.name
        countryDB.currencySymbol = countryEntity.currencies?.first?.symbol
        return countryDB
    }
    
    private func countryDBToEntity(_ countryDB: CountryDB) -> CountryEntity {
        
        return CountryEntity(name: countryDB.name ?? "", capital: countryDB.capital, flags: Flags(png: countryDB.flag ?? ""), currencies: [Currency(code: countryDB.currencyCode ?? "", name: countryDB.currencyName ?? "", symbol: countryDB.currencySymbol ?? "")])
    }
}
