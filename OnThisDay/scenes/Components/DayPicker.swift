//
//  DayPicker.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import SwiftUI
import OTDNetwork

struct DayPicker: View {
    @EnvironmentObject private var appState: AppState
    
    @SceneStorage(kSelectedDate) var selectedDate: String?
    
    @State private var month = "January"
    @State private var day = 1
    
    var body: some View {
        VStack {
            Text("Select a Date")
            
            HStack {
                Picker("", selection: $month) {
                    ForEach(appState.englishMonthNames, id: \.self) { month in
                        Text(month)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("", selection: $day) {
                    ForEach(1...DayPickerMapper.maxDays(for: month), id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: 60)
                .padding(.trailing, 10)
            }
            
            PickerControlView()
                .padding()
        }
        .padding()
    }
    
    @ViewBuilder
    private func PickerControlView() -> some View {
        if appState.isLoading {
            ProgressView()
                .frame(height: 28)
        } else {
            Button("Get Events") {
                Task {
                    await getNewEvents()
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
    
    private func getNewEvents() async {
        let monthIndex = appState.englishMonthNames
            .firstIndex(of: month) ?? 0

        let monthNumber = monthIndex + 1
        
        await appState.getDataFor(month: monthNumber, day: day)
        
        selectedDate = "\(month) \(day)"
    }
}


#Preview {
    let storage = CDStorageService()
    DayPicker()
        .environmentObject(
            AppState(
                repo: DayDataSourceRepository(
                    remote: ClientAPIService(
                        networking: URLNetworkService(urlSession: .shared)
                    ),
                    local: LocalDayDataSource(storageService: storage),
                    storage: storage
                )
            )
        )
        .frame(width: 200)
}
