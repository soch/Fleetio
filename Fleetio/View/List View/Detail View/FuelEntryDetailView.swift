//
//  FuelEntryDetailView.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import SwiftUI

struct FuelEntryDetailView: View {
    var fuelEntry:FuelEntry
    
    var body: some View {
        GroupBox( label: Label(fuelEntry.date.formatDateString(), systemImage: "calendar")){
            Spacer().frame(height:20)
            VStack(spacing:15){
                HStack{
                    Cell(model: CellModel(title:"Miles/Gallon", value: fuelEntry.mpgUs?.formatDouble() ?? "--"))
                    Spacer()
                    Cell(model: CellModel(title:"Cost/Mile", value: fuelEntry.costPerMi?.formatDouble() ?? "--"))
                }
                
                HStack{
                    Cell(model: CellModel(title:"Miles Driven", value: fuelEntry.usageInMi ?? "--"))
                    Spacer()
                    Cell(model: CellModel(title:"Gallons", value: fuelEntry.usGallons))
                }
                
                HStack{
                    Cell(model: CellModel(title:"Fuel Type", value: fuelEntry.fuelTypeName ?? "--"))
                    Spacer()
                    Cell(model: CellModel(title:"Price/Gallon", value: fuelEntry.pricePerVolumeUnit?.formatDouble() ?? "--"))
                }
                
                HStack{
                    Cell(model: CellModel(title:"Vendor", value: fuelEntry.vendorName ?? "--"))
                    Spacer()
                    Cell(model: CellModel(title:"Reference", value: fuelEntry.reference ?? "--"))
                }
                
            }
        }.padding()
            .navigationTitle(fuelEntry.vehicleName)
        Spacer()
    }
}

struct Cell: View {
    var model: CellModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.system(size: 13.0, weight: .light))
                .frame(width: 150, alignment: .leading)
            Text(model.value)
                .frame(width: 150, alignment: .leading)
        }
    }
}

struct CellModel {
    var title : String
    var value : String
}

