//
//  ContentView.swift
//  Fleetio
//
//  Created by Amit Jain on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fuelEntryManager = FuelEntryViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    FuelEntriesListView()
                        .environmentObject(fuelEntryManager)
                }.navigationTitle("Fleetio Fuel Entries")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("List", systemImage: "list.dash")
            }
            
            FuelEntriesMapView()
                .environmentObject(fuelEntryManager)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
