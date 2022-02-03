//
//  Place.swift
//  Fleetio
//
//  Created by Amit Jain on 1/30/22.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id:Int
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
