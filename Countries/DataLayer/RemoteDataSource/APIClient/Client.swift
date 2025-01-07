//
//  Client.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

import Foundation

class BaseAPIClient {
    
    //MARK: - Properties
    var baseUrl : String
    
    //MARK: - Initallizer
    init(baseUrl: String){
        
        self.baseUrl = baseUrl
    }

    //MARK: - Methods
    private func createTaskAndHandleResponseHelper<T: Decodable>() async throws -> T {
        
        guard let url = createURL(path: baseUrl) else { throw APIError.generalError }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            
            if let urlError = error as? URLError {
                throw APIError.generalError
            } else if let decodingError = error as? DecodingError  {
                throw APIError.decodingError(decodingError)
            }
            throw error
        }
    }
    
    private func createURL(path: String) -> URL? {
        
        return URLComponents(string: "\(baseUrl)\(path)")?.url
    }
}
