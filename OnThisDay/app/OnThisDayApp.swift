//
//  OnThisDayApp.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import SwiftUI
import OTDNetwork

@main
struct OnThisDayApp: App {
    @AppStorage(kDisplayMode) private var displayMode: DisplayMode = .auto
    
    // TODO: Replace with DI Container later
    
    @StateObject private var appState: AppState = {
        let storageService = CDStorageService()
        
        return AppState(
            repo: DayDataSourceRepository(
                remote: ClientAPIService(
                    networking: URLNetworkService(urlSession: .shared)
                ),
                local: LocalDayDataSource(storageService: storageService),
                storage: storageService
            )
        )
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appState)
                .onAppear {
                    AppTheme.changeDisplayMode(to: displayMode)
                }
                .onChange(of: displayMode) { _, newValue in
                    AppTheme.changeDisplayMode(to: newValue)
                }
        }
        .commands {
            Menus()
        }
        
        Settings {
            PreferencesView()
        }
    }
}
