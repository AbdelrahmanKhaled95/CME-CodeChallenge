//
//  CountriesApp.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import SwiftUI

@main
struct CountriesApp: App {

    var body: some Scene {
        WindowGroup {
            CountryListRouter.createModule()
        }
    }
}
