//
//  CountryDetailsRouter.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

import SwiftUI

class CountryDetailsRouter {
    
    var view: (any View)?
        
    static func createModule(with country: CountryModel) -> some View {
                
        let router = CountryDetailsRouter()
        let viewModel = CountryDetailsViewModel(country: country)
        let view = CountryDetailsView(viewModel: viewModel)
        router.view = view
        return view
    }
}
