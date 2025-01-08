//
//  CountryListTests.swift
//  CountriesTests
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

import XCTest
@testable import Countries

final class CountryListTests: XCTestCase {
    
    func test_checkCachedData_success() {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = []
        
        //Then
        XCTAssertTrue(useCase.countryCached)
    }
    
    func test_getLoaction_success() {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = []
        
        //Then
        XCTAssertTrue(location.locationRequested)
    }
    
    func test_getLoaction_failed() {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: false)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = [DummyData.country]
        
        //Then
        XCTAssertFalse(location.locationRequested)
    }
    
    func test_removeCountry_success() {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: false)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = [DummyData.country]
        viewModel.removeCountry(at: IndexSet(integer: 0))
        
        //Then
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
    
    func test_validEntry_emptyString() async {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = []
        await viewModel.search(with: "")
        
        //Then
        XCTAssertEqual(CountryListError.emptySearchField.message,
                  viewModel.errorMessage)
    }
    
    func test_validEntry_moreThanEqual5() async {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = Array(repeating: DummyData.country,
                                        count: 5)
        await viewModel.search(with: "Egypt")
        
        //Then
        XCTAssertEqual(CountryListError.fullList.message,
                       viewModel.errorMessage)
    }
    
    func test_validEntry_duplicate() async {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = [DummyData.country]
        await viewModel.search(with: "Egypt")
        
        //Then
        XCTAssertEqual(CountryListError.duplicate.message,
                       viewModel.errorMessage)
    }
    
    func test_search_wrongName() async {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true, isValidCountry: false)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = []
        await viewModel.search(with: "Egypt")
        
        //Then
        XCTAssertEqual(CountryListError.wrongName("Egypt").message,
                       viewModel.errorMessage)
    }
    
    func test_search_success() async {
        
        //Given
        let useCase = FakeSearchUseCase(isEmptyCache: true, isValidCountry: true)
        let location = FakeLocationManager()
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: location)
        //When
        viewModel.searchResults = []
        await viewModel.search(with: "Egypt")
        
        //Then
        XCTAssertTrue(!viewModel.searchResults.isEmpty)
    }
}
