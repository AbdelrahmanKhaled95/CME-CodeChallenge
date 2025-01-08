//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import Foundation
import CoreData

class CountryListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var searchResults: [CountryModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // MARK: - Stored Properties
    private let useCase: SearchCountryUseCaseProtocol
    private let locationManager: LocationManagerProtocol
    
    // MARK: - Init
    init(useCase: SearchCountryUseCaseProtocol,
         locationManager: LocationManagerProtocol) {
        self.useCase = useCase
        self.locationManager = locationManager
        
        didLoad()
    }
    
    // MARK: - Methods
    private func didLoad() {
        
        checkCachedData()
        getLoaction(searchResults.isEmpty)
    }
    
    private func getLoaction(_ isEnabled: Bool) {
        
        guard isEnabled else { return }
        
        isLoading = true
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    private func checkCachedData() {
        
        isLoading = true
        searchResults = useCase.cached()
        isLoading = false
    }
    
    private func validEntry(query: String) -> Bool {
        
        if query.trimmingCharacters(in: .whitespaces).isEmpty {
            showError = true
            errorMessage = CountryListError.emptySearchField.message
            return false
        }
        
        if searchResults.count >= 5 {
            showError = true
            errorMessage = CountryListError.fullList.message
            return false
        }
        
        if searchResults.contains(where: { $0.name?.lowercased() == query.lowercased() }) {
            showError = true
            errorMessage = CountryListError.duplicate.message
            return false
        }
        
        return true
    }
    
    @MainActor
    func search(with country: String) async {
        
        guard validEntry(query: country) else { return }
        
        isLoading = true
        
        do {
            guard let country = try await useCase.search(for: country) else {
                isLoading = false
                showError = true
                errorMessage = CountryListError.wrongName(country).message
                return
            }
            
            searchResults.append(country)
            isLoading = false
            
        } catch {
            isLoading = false
            showError = true
            errorMessage = CountryListError.other(error.localizedDescription).message
        }
    }
    
    func removeCountry(at offsets: IndexSet) {
        
        guard let index = offsets.first else { return }
        useCase.deleteCachedCountry(searchResults[index])
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
