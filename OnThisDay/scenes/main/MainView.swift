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
    
    private var events: [Event] {
        appState.dataFor(eventType: sidebarEventTypeSelection)
    }
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectionType: $sidebarEventTypeSelection)
        } detail: {
            GridView(event: events)
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
    }
    
    private var navigationTitle: String {
        if let eventType = sidebarEventTypeSelection {
            return "On This Day - \(eventType.rawValue)"
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
