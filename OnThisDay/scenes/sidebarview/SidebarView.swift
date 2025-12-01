//
//  SidebarView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import SwiftUI
import Foundation

struct SidebarView: View {
    @EnvironmentObject private var appState: AppState
    @AppStorage(kShowTotalsMainView) private var showTotals: Bool = true
    @AppStorage(kShowBirths) private var showBirths = true
    @AppStorage(kShowDeaths) private var showDeaths = true
    
    @SceneStorage(kSelectedDate) var selectedDate: String?
    
    private var validTypes: [EventType] {
        var types = [EventType.events]
        
        if showBirths {
            types.append(.births)
        }
        
        if showDeaths {
            types.append(.deaths)
        }
        
        return types
    }
    
    @Binding var selectionType: EventType?
    
    var body: some View {
        VStack {
            List(selection: $selectionType) {
                Section(selectedDate?.uppercased() ?? "TODAY") {
                    ForEach(validTypes, id: \.self) { eventType in
                        Text(eventType.rawValue)
                            .padding(.vertical, 3)
                            .badge(showTotals ? appState.count(for: eventType, date: selectedDate) : 0)
                    }
                }
                
                Section("AVAILABLE DATES") {
                    ForEach(appState.sortedDates, id: \.self) { date in
                        Button {
                            selectedDate = date
                        } label: {
                            HStack {
                                Text(date)
                                Spacer()
                            }
                        }
                        .controlSize(.large)
                        .modifier(DateButtonViewModifier(selected: selectedDate == date))
                    }
                }
            }
            .listStyle(.sidebar)
            
            Spacer()
            
            DayPicker()
        }
        .frame(minWidth: 220)
    }
}

#Preview {
    SidebarView(
        selectionType: .constant(.births)
    )
    .frame(width: 200)
}
