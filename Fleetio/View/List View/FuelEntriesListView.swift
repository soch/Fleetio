//
//  FuelEntriesListView.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import SwiftUI

struct FuelEntriesListView: View {
    @EnvironmentObject var fuelEntryManager: FuelEntryViewModel
    var body: some View {
        VStack
        {
            if fuelEntryManager.loading {
                ProgressView()
            } else {
                List {
                    ForEach(fuelEntryManager.fuelEntries.keys.sorted(),id: \.self) { key in
                        Section(header:  VStack(alignment: .leading) {
                            HStack {
                                Text(key)
                                    .fontWeight(.bold)
                            }
                        }) {
                            SectionView(fuelEntries: fuelEntryManager.fuelEntries[key]!)
                        }
                    }
                    HStack {
                        if (fuelEntryManager.nextPage){
                            Button("Load More...") {
                                loadMore()
                            }
                        }
                        Spacer()
                        Text ("Page:\(fuelEntryManager.currentPage)")
                    }
                }.listStyle(PlainListStyle())
                    .environment(\.defaultMinListRowHeight, 100)
            }
        }
        .task { // cancells  automatically on view disappearing
            await fuelEntryManager.fetchFuelEntries()
        }
        .refreshable {
            await fuelEntryManager.fetchFuelEntries()
        }
    }
    
    func loadMore()  {
        Task {
            let nextPage = fuelEntryManager.currentPage+1
            await fuelEntryManager.fetchFuelEntries(page: nextPage ) //load next page
        }
    }
}

struct SectionView : View {
    var fuelEntries : [FuelEntry]
    var body: some View {
        ScrollView(.horizontal) {
            HeaderRow()
            Divider()
            ForEach (fuelEntries, id: \.id  ) {(fuelEntry) in
                FuelEntryRowView(fuelEntry:fuelEntry)
                if fuelEntry.id != fuelEntries.last?.id {
                    Divider()
                }
            }
        }
    }
}

struct FuelEntriesListView_Previews: PreviewProvider {
    static var previews: some View {
        FuelEntriesListView()
    }
}
