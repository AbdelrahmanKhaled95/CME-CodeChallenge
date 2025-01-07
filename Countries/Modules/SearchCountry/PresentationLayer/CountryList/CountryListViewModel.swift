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
    private let locationManager: LocationManagerProtocol
    
    // MARK: - Init
    init(useCase: SearchCountryUseCaseProtocol, 
         router: CountryListRouterProtocol,
         locationManager: LocationManagerProtocol) {
        self.useCase = useCase
        self.router = router
        self.locationManager = locationManager
        
        didLoad()
    }
    
    // MARK: - Methods
    private func didLoad() {
        
        isLoading = true
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    private func validEntry(query: String) -> Bool {
        
        if query.trimmingCharacters(in: .whitespaces).isEmpty {
            showError = true
            errorMessage = "Please enter a country to search"
            return false
        }
        
        if searchResults.count >= 5 {
            showError = true
            errorMessage = "Can't add more countries, Please remove atleast one"
            return false
        }
        
        return true
    }
    
    func search(with country: String) async {
        
        guard validEntry(query: country) else { return }
        
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

//MARK: - LocationManagerDelegate
extension CountryListViewModel: LocationManagerDelegate {
    func didGetLocation(country: String) {
        Task {
            await search(with: country)
        }
    }
}
