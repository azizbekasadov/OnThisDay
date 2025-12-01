//
//  PreferencesView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        Group {
            if #available(macOS 15.0, *) {
                content
                    .tabViewStyle(.tabBarOnly)
                    .frame(
                        width: 210,
                        height: 150
                    )
            } else {
                content
                    .frame(
                        width: 200,
                        height: 150
                    )
            }
        }
        .navigationTitle("Settings")
    }
    
    @ViewBuilder
    private var content: some View {
        TabView {
            ShowView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Show")
                }
            
            AppearanceView()
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Appearance")
                }
        }
    }
}

#Preview {
    PreferencesView()
}
