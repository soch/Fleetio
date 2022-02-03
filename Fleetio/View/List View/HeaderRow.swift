//
//  HeaderRow.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import SwiftUI

struct HeaderRow: View {
    var body: some View {
        //Some of the most important data fields to surface to the user are: date, vehicle name, cost, cost per mile, gallons, fuel type, price per gallon, vendor, reference number
        HStack {
            Group {
                Text("Date")
                    .formatLongHeader()
                Divider()
                Text("Gallons")
                    .formatHeader()
                Divider()
                
                Text("Price/gallon")
                    .formatHeader()
                Divider()
            }
            Group {
                Text("Cost/MI")
                    .formatHeader()
                Divider()
                
                Text("Cost")
                    .formatHeader()
                Divider()
                
                Text("Fuel Type")
                    .formatHeader()
                Divider()
            }
        }
    }
}

struct HeaderRow_Previews: PreviewProvider {
    static var previews: some View {
        HeaderRow()
    }
}
