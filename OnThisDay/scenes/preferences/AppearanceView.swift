//
//  AppearanceView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import SwiftUI

struct AppearanceView: View {
    @AppStorage(kDisplayMode) var displayMode = DisplayMode.auto
    
    var body: some View {
        Picker("", selection: $displayMode) {
            Text("Light")
                .tag(DisplayMode.light)
            Text("Dark")
                .tag(DisplayMode.dark)
            Text("Automatic")
                .tag(DisplayMode.auto)
        }
        .pickerStyle(.radioGroup)
    }
}

#Preview {
    AppearanceView()
        .frame(width: 200, height: 150)
}
