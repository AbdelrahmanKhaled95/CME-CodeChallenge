//
//  CountryListRouter.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import SwiftUI

protocol CountryListRouterProtocol {
    
}

class CountryListRouter {
        
    static func createModule() -> some View {
        
        let router = CountryListRouter()
        let useCase = SearchCountryUseCase(searchRepo: SearchRepo())
        let viewModel = CountryListViewModel(useCase: useCase, router: router)
        let view =  CountryListView(viewModel: viewModel)
        
        return view
    }
}

extension CountryListRouter: CountryListRouterProtocol {
    
    
    
}
