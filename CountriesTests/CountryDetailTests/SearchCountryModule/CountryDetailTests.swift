//
//  CountryDetailTests.swift
//  CountriesTests
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

import XCTest
@testable import Countries

final class CountryDetailTests: XCTestCase {
    
    func test_loadValues() {
        
        //Given
        let country = DummyData.country
        
        //When
        let viewModel = CountryDetailsViewModel(country: country)
        
        //Then
        XCTAssertEqual(viewModel.name, country.name)
    }
}
