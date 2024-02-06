//
//  ConstantModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import SwiftUI
import MapKit


final class ConstantModel{
    
}

extension CLLocationCoordinate2D{
    static var userLocation : CLLocationCoordinate2D{
        return .init(latitude: 33.41440927242265, longitude: -111.92180791396257)
    }
}

extension MKCoordinateRegion {
    static var userRegion : MKCoordinateRegion {
        return  .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

