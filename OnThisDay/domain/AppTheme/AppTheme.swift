//
//  AppTheme.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 15.11.2025.
//

import AppKit
import SwiftUI

enum AppTheme {
    static func changeDisplayMode(to mode: DisplayMode) {
        @AppStorage("displayMode") var displayMode = DisplayMode.auto
        displayMode = mode
        switch mode {
        case .light:
            NSApp.appearance = NSAppearance(named: .aqua)
        case .dark:
            NSApp.appearance = NSAppearance(named: .darkAqua)
        case .auto:
            NSApp.appearance = nil
        }
    }
}
