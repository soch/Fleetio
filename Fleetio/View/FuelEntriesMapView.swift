//
//  FuelEntriesMapView.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import SwiftUI
import MapKit

struct FuelEntriesMapView: View {
    @EnvironmentObject var fuelEntryManager: FuelEntryViewModel
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.0902, longitude:-95.7129), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 60))
    
    var body: some View {
        CustomAnnotationMapView(region: region)
            .environmentObject(fuelEntryManager)
    }
}

struct FuelEntriesMapView_Previews: PreviewProvider {
    static var previews: some View {
        FuelEntriesMapView()
    }
}

struct CustomAnnotationMapView: View {
    @EnvironmentObject var fuelEntryManager: FuelEntryViewModel
    @State var region: MKCoordinateRegion
    @State var places:[Place] = []
    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: places
        ) { place in
            MapMarker(coordinate: place.coordinate)
        }
        .onAppear {
            places = fuelEntryManager.findGeoLocations()
        }
    }
}

