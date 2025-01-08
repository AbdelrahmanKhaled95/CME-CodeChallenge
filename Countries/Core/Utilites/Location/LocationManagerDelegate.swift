//
//  LocationManagerDelegate.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 7/1/25.
//

protocol LocationManagerDelegate: AnyObject {
    
    func didGetLocation(country: String)
}
