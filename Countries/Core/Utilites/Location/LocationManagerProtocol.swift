//
//  LocationManagerProtocol.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

protocol LocationManagerProtocol: AnyObject {
    
    var delegate: LocationManagerDelegate? { get set }
    func requestLocation()
}
