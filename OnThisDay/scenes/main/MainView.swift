//
//  MainView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var appState: AppState
    @State private var sidebarEventTypeSelection: EventType? = .events
    @State private var searchText: String = ""
    @State private var viewMode: ViewMode = .grid
    
    @SceneStorage(kSelectedDate) var selectedDate: String?
    
    private var events: [Event] {
        appState.dataFor(
            eventType: sidebarEventTypeSelection,
            date: selectedDate,
            searchText: searchText
        )
    }
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectionType: $sidebarEventTypeSelection)
        } detail: {
            switch viewMode {
            case .grid:
                GridView(event: events)
            case .table:
                TableView(tableData: events)
            }
        }
        .navigationTitle(navigationTitle)
        .frame(
            minWidth: 700,
            idealWidth: 1000,
            maxWidth: .infinity,
            minHeight: 400,
            idealHeight: 800,
            maxHeight: .infinity
        )
        .searchable(text: $searchText)
        .onAppear {
            if sidebarEventTypeSelection == nil {
                sidebarEventTypeSelection = .events
            }
        }
        .toolbar(id: "OTDToolbar") {
            OTDToolbar(viewMode: $viewMode)
        }
    }
    
    private var navigationTitle: String {
        if let eventType = sidebarEventTypeSelection, let selectedDate {
            return "On This Day - \(selectedDate) - \(eventType.rawValue)"
        }
        
        return "On This Day" + " - " + Date().formatted(date: .abbreviated, time: .shortened)
    }
}

#Preview("MainView") {
    MainView()
}

#Preview("SidebarView") {
    SidebarView(selectionType: .constant(.births))
        .frame(width: 200)
}
