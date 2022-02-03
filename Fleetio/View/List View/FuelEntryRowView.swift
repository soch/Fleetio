//
//  FuelEntryRowView.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import SwiftUI

//date, cost, cost per mile, gallons, fuel type, price per gallon

struct FuelEntryRowView: View {
    var fuelEntry: FuelEntry
    var body: some View {
        NavigationLink(destination:FuelEntryDetailView(fuelEntry:fuelEntry)) {
            HStack {
                Group {
                    VStack {
                        Text(fuelEntry.date.formatDateString()).formatLongCell()
                    }
                    Divider()
                    Text (fuelEntry.usGallons).formatCell()
                    Divider()
                }
                Group {
                    Text (fuelEntry.pricePerVolumeUnit?.formatDouble() ?? "").formatCell()
                    Divider()
                    
                    Text ( fuelEntry.costPerMi?.formatDouble() ?? "").formatCell()
                    Divider()
                    
                    Text (fuelEntry.costPerHr?.formatDouble() ?? "").formatCell()
                    Divider()
                    
                    Text (fuelEntry.fuelTypeName ?? "").formatCell()
                    Divider()
                }
            }
        }
    }
}


