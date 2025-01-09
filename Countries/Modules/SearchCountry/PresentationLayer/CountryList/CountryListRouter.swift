//
//  CountryListRouter.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import SwiftUI

class CountryListRouter {
    
    var view: (any View)?
        
    static func createModule() -> some View {
        
        let locationManager = LocationManager()
        
        let router = CountryListRouter()
        let useCase = SearchCountryUseCase(searchRepo: SearchRepo())
        let viewModel = CountryListViewModel(useCase: useCase,
                                             locationManager: locationManager)
        let view = CountryListView(viewModel: viewModel)
        router.view = view
        return view
    }
}
