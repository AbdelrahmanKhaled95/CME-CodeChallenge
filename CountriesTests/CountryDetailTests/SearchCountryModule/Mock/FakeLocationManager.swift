//
//  FakeLocationManager.swift
//  CountriesTests
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

@testable import Countries

class FakeLocationManager: LocationManagerProtocol {
    
    var locationRequested: Bool = false
    weak var delegate: Countries.LocationManagerDelegate?
    
    func requestLocation() {
        locationRequested = true
        delegate?.didGetLocation(country: "Egypt")
    }
}
