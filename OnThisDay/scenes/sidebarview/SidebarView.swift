//
//  SidebarView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import SwiftUI
import Foundation

struct SidebarView: View {
    private let eventTypes: [EventType] = [
        .events, .deaths, .births
    ]
    
    @Binding var selectionType: EventType?
    
    var body: some View {
        List(selection: $selectionType) {
            Section("TODAY") {
                ForEach(eventTypes, id: \.self) { eventType in
                    Text(eventType.rawValue)
                        .padding(.vertical, 3)
                }
            }
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    SidebarView(
        selectionType: .constant(.births)
    )
    .frame(width: 200)
}
