//
//  TableView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import SwiftUI

struct TableView: View {
    @State private var sortOrder = [KeyPathComparator(\Event.year)]
    @State private var selectedEventID: UUID?//s: Set<UUID> = []
    
    private var tableData: [Event]
    
    private var sortedTableData: [Event] {
        tableData.sorted(using: sortOrder)
    }
    
    private var selectedEvent: Event? {
        guard let selectedEventID else {
            return nil
        }
        
        let event = tableData.first { $0.id == selectedEventID }
        return event
    }
    
    init(tableData: [Event]) {
        self.tableData = tableData
    }
    
    var body: some View {
        HStack {
            Table(
                sortedTableData,
                selection: $selectedEventID,
                sortOrder: $sortOrder
            ) {
                TableColumn("Year", value: \.year) {
                    Text($0.year)
                }
                .width(min: 55, ideal: 65, max: 100)
                
                TableColumn("Title", value: \.text) {
                    Text($0.text)
                }
            }
            .tableStyle(.inset)
            
            SideEventDetailsView()
        }
    }
    
    @ViewBuilder
    private func SideEventDetailsView() -> some View {
        if let selectedEvent = selectedEvent {
            EventView(event: selectedEvent)
                .frame(width: 250)
        } else {
            Text("Select an event for more details…")
                .font(.title3)
                .padding()
                .frame(width: 250)
        }
    }
}

#Preview {
    TableView(tableData: [Event.sampleEvent])
}
