//
//  APIError.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import Foundation

 enum APIError {
    case generalError
    case decodingError(Error)
}


extension APIError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
        case .generalError:
            return "Something went wrong, please try again later"
        case let .decodingError(error):
            return "Decoding Error, please check \(error.localizedDescription)"
        }
    }
}
