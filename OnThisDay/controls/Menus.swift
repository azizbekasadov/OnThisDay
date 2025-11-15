//
//  Menus.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 15.11.2025.
//

import SwiftUI

struct Menus: Commands {
    @AppStorage(kShowTotalsMainView) private var showTotals: Bool = true
    @AppStorage(kDisplayMode) private var displayMode: DisplayMode = .auto
    
    var body: some Commands {
        SidebarCommands()
        ToolbarCommands()
        
        CommandGroup(before: .help) {
            Button("On this day - Support Site") {
                showAPIWebSite()
            }
            .keyboardShortcut("/", modifiers: [.command])
        }
        
        CommandMenu("Display") {
            Toggle(isOn: $showTotals) {
                Text("Show Totals")
            }
            .keyboardShortcut("t", modifiers: [.command])
            
            Divider()
            
            Picker("Appearance", selection: $displayMode) {
                ForEach(DisplayMode.allCases, id: \.self) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
        }
    }
    
    private func showAPIWebSite() {
        let address = "https://today.zenquotes.io"
        
        guard let url = URL(string: address) else {
            fatalError("Invalid address")
        }
        
        NSWorkspace.shared.open(url)
    }
}
