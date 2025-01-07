//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import Foundation

class CountryListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var searchText: String = ""
    @Published var searchResults: [CountryModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // MARK: - Stored Properties
    private let useCase: SearchCountryUseCaseProtocol
    private let router: CountryListRouterProtocol
    
    // MARK: - Init
    init(useCase: SearchCountryUseCaseProtocol, router: CountryListRouterProtocol) {
        self.useCase = useCase
        self.router = router
    }
    
    // MARK: - Methods
    func search(with country: String) async {
        
        guard !country.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            showError = true
            errorMessage = "Please enter a country to search"
            return
        }
        
        guard searchResults.count < 5 else {
            showError = true
            errorMessage = "Can't add more countries, Please remove atleast one"
            return
        }
        
        isLoading = true
        
        do {
            guard let country = try await useCase.search(for: country) else {
                isLoading = false 
                showError = true
                errorMessage = "No country with this name \(country) was found"
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.searchResults.append(country)
                self?.isLoading = false 
            }
            
        } catch {
            isLoading = false
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func removeCountry(at offsets: IndexSet) {
        searchResults.remove(atOffsets: offsets)
    }
}
