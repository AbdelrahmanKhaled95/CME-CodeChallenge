//
//  Environment.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import Foundation

enum Environment {

    static var baseUrl: String {

        guard
            let urlString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {

            fatalError("Missing InfoPlist BaseURL")
        }
        return urlString
    }
}
