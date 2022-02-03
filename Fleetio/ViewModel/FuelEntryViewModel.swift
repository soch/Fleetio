//
//  FuelEntryViewModel.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import Foundation
import MapKit

class FuelEntryViewModel : ObservableObject {

    var fuelEntries = Dictionary<String, [FuelEntry]>()
    @Published var loading:Bool = true
    @Published var nextPage:Bool = true
    @Published var currentPage:Int = 0
    
    func  fetchFuelEntries(page:Int = 0) async {
        do {
            let parameters = [ "page":String(page), "q[geolocation_gps_device_present]":String(1)]
            let fuelEntryService:FuelEntryService = FuelEntryService(parameters: parameters)
            let (fuelData, headerResponse) = try await fuelEntryService.callFuelEntriesApi()
            DispatchQueue.main.async { [weak self] in //can use @MainActor on the VM, but then request & response go on mainQ.
                                                      //group entries by vehicle name to create List sections
                self?.fuelEntries = Dictionary(grouping: fuelData, by: {$0.vehicleName})
                self?.loading = false
                if let currentPage:String = headerResponse["X-Pagination-Current-Page"] as? String  {
                    self?.currentPage = Int(currentPage) ?? 0
                    if let lastPage:String = headerResponse["X-Pagination-Total-Pages"] as? String {
                        if self?.currentPage ?? 0 <  Int(lastPage) ?? 0 {
                            self?.nextPage = true
                        } else {
                            self?.nextPage = false
                        }
                    }
                }
            }
        } catch {
            print("Fetching fuel entries failed with error \(error)")
            DispatchQueue.main.async { [weak self] in
                self?.loading = false
            }
        }
    }
    
    func findGeoLocations () -> [Place] {
        var places:[Place] = []
        for (vehicleName,fuelList) in self.fuelEntries {
            var place:Place
            for fuelEntry  in  fuelList {
                if let geo = fuelEntry.geolocation {
                    if let coord = returnCoordinates(geoLocation: geo) {
                        place = Place(id:fuelEntry.id, name:vehicleName , latitude: coord.latitude, longitude: coord.longitude)
                        places.append(place)
                    }
                }
            }
        }
        return places
    }
    
    func returnCoordinates(geoLocation:Geolocation) ->  CLLocationCoordinate2D? {
        if let lat = geoLocation.latitude, let lon = geoLocation.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        if let lat = geoLocation.fleetioFuel?.latitude, let lon = geoLocation.fleetioFuel?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        
        //        if let lat = geoLocation.gpsDevice?.latitude, let lon = geoLocation.gpsDevice?.longitude {
        ////TODO: Handle data corruption
        //
        //        }
        
        return nil
    }
}
