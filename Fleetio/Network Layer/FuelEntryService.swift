//
//  FuelEntryService.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import Foundation
class FuelEntryService: NetworkService {
    
    var path = "/fuel_entries"
    let httpMethodtype = HttpMethod.GET
    var parameters: [String : Any]

    required init(parameters: [String : Any]) {
        self.parameters = parameters
    }
    
    func callFuelEntriesApi() async throws  -> ([FuelEntry],[AnyHashable : Any]) {
        let (fuelEntries,responseHeaders): ([FuelEntry],[AnyHashable : Any]) = try await fetchAPI()
#if DEBUG
        if let  fuelEntry = fuelEntries.first(where: { $0.vehicleName == "#1 Kubota Redux" }) {
            print("Resp: \(fuelEntry)")
        }
#endif
        return (fuelEntries,responseHeaders)
    }
}
