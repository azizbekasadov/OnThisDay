//
//  Toolbars.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 15.11.2025.
//

import SwiftUI
import AppKit

struct OTDToolbar: CustomizableToolbarContent {
    @Binding var viewMode: ViewMode
    
    var body: some CustomizableToolbarContent {
        ToolbarItem(
            id: "sidebar_toolbar",
            placement: .navigation,
            showsByDefault: true
        ) {
            Button {
                toggleSidebar()
            } label: {
                Label("Toggle Sidebar", systemImage: "sidebar.left")
            }
            .help("Toggle Sidebar")
        }
        
        ToolbarItem(
            id: "view_mode",
            placement: .navigation
        ) {
            Picker(
                "View Mode",
                selection: $viewMode
            ) {
                Label("Grid", systemImage: "square.grid.3x2")
                    .tag(ViewMode.grid)
                Label("Table", systemImage: "tablecells")
                    .tag(ViewMode.table)
            }
            .pickerStyle(.segmented)
            .help("Switch between Grid and Table")
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?
            .contentViewController?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
