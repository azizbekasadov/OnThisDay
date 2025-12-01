//
//  Toolbars.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 15.11.2025.
//

import SwiftUI
import AppKit

struct OTDToolbar: CustomizableToolbarContent {
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
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?
            .contentViewController?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
