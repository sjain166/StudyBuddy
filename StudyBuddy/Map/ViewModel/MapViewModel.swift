//
//  MapViewModel.swift
//  StudyBuddy
//
//  Created by Siddharth Jain on 11/22/23.
//

import Foundation
import MapKit
import SwiftUI

@MainActor
final class MapViewModel : ObservableObject{
    @Published var selectionLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    @Published var selectedRegion : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.41440927242265, longitude: -111.92180791396257) , latitudinalMeters: 10000 , longitudinalMeters: 10000)
    @Published var cameraPostion : MapCameraPosition = .region(.userRegion)
    
    func getCoordinateRegionForCity(cityName: String, completion: @escaping (MKCoordinateRegion?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(cityName) { placemarks, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinates = location.coordinate
                let coordinateRegion = MKCoordinateRegion(
                    center: coordinates,
                    span: MKCoordinateSpan(latitudeDelta: 1000 , longitudeDelta: 1000)
                )
                self.selectionLocation = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
                self.selectedRegion = MKCoordinateRegion(center: self.selectionLocation , latitudinalMeters: 50000, longitudinalMeters: 50000)
                self.cameraPostion = .region(self.selectedRegion)
                completion(coordinateRegion, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func setMapView(cityName : String){
        getCoordinateRegionForCity(cityName: cityName) { coordinateRegion, error in
            if let error = error {
                print("Error geocoding city: \(error.localizedDescription)")
            } else if let coordinateRegion = coordinateRegion {
                print("Location Displayed")
            }
        }
    }
}
