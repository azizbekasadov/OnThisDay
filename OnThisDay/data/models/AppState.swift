//
//  AppState.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Combine
import Foundation

final class AppState: ObservableObject {
    @Published var days: [String: Day] = [:]
    
    // MARK: - State
    @Published var loadingError = false
    @Published var isLoading = false
    
    private let repo: DayDataSourceRepositoryProto
    
    init(
        repo: DayDataSourceRepositoryProto
    ) {
        self.repo = repo
        
        Task {
            await getToday()
        }
    }
    
    func dataFor(
        eventType: EventType?,
        date: String? = nil,
        searchText: String = ""
    ) -> [Event] {
        let requestedDate = date ?? today
        if let day = days[requestedDate] {
            let events: [Event]
            switch eventType {
            case .births:
                events = day.births
            case .deaths:
                events = day.deaths
            case .events, .none:
                events = day.events
            }
            
            if searchText.isEmpty {
                return events
            } else {
                let searchTextLower = searchText.lowercased()
                let filteredEntries = events.filter { event in
                    event.text.lowercased().contains(searchTextLower)
                    || event.year.lowercased().contains(searchTextLower)
                }
                return filteredEntries
            }
        }
        
        if let date = date {
            downloadMissingEvents(for: date)
        }
        
        return []
    }
    
    func count(
        for eventType: EventType = .events,
        date: String? = nil,
        searchText: String = ""
    ) -> Int {
        dataFor(eventType: eventType, date: date, searchText: searchText).count
    }
    
    /// Async method to trigger the download of today's `Day`.`
    /// Marked as @MainActor as it will trigger a UI update that must be done on the main thread.
    @MainActor func getToday() async {
        let (month, day) = currentMonthAndDay()
        await getDataFor(month: month, day: day)
    }
    
    /// Method to download the data for the specified month & day, decode it into a `Day`
    /// and add it to `days` which will publish the change
    /// - Parameters:
    ///   - month: month  as integer: January = 1
    ///   - day: day as integer
    @MainActor func getDataFor(month: Int, day: Int) async {
        loadingError = false
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        let monthName = englishMonthNames[month - 1]
        let dateString = "\(monthName) \(day)"
        if days[dateString] != nil {
            return
        }
        
        do {
            let newData = try await repo.getData(for: day, month: month)
            days[newData.displayDate] = newData
        } catch {
            loadingError = true
        }
    }
    
    /// Used to force a UI refesh
    /// - Parameter date: display date fof the specific `Day` e.g. "June 29".
    func toggleEventsFor(date: String?) {
        if let date = date, let day = days[date] {
            days[date] = nil
            days[date] = day
        }
    }
    
    /// Get the month number and day number for today.
    /// Defaults to January 1
    /// - Returns: a tuple with two integers: month, day
    func currentMonthAndDay() -> (monthNum: Int, dayNum: Int) {
        let calendarDate = Calendar.current.dateComponents([.day, .month], from: Date())
        
        if let dayNum = calendarDate.day, let monthNum = calendarDate.month {
            return (monthNum, dayNum)
        }
        return (1, 1)
    }
    
    /// Computed variable to return the display date for today e.g. "June 29".
    var today: String {
        let (monthNum, dayNum) = currentMonthAndDay()
        let month = englishMonthNames[monthNum - 1]
        return "\(month) \(dayNum)"
    }
    
    /// Computed variable to return the keys from `days` sorted by date.
    var sortedDates: [String] {
        let dates = days.values.compactMap { day in
            return day.displayDate
        }
        
        let sortedDates = dates.sorted { lhs, rhs in
            let lhParts = lhs.components(separatedBy: " ")
            let rhParts = rhs.components(separatedBy: " ")
            let lhMonth = lhParts[0]
            let rhMonth = rhParts[0]
            let lhDay = Int(lhParts[1]) ?? 32
            let rhDay = Int(rhParts[1]) ?? 32
            let lhMonthNumber = englishMonthNames.firstIndex(of: lhMonth) ?? 13
            let rhMonthNumber = englishMonthNames.firstIndex(of: rhMonth) ?? 13
            return (lhMonthNumber * 100 + lhDay) < (rhMonthNumber * 100 + rhDay)
        }
        
        return sortedDates
    }
    
    /// Method to trigger the download for a date if that date was requested but is not available.
    /// - Parameter date: display date for the specific date  e.g. "June 29".
    func downloadMissingEvents(for date: String) {
        if isLoading {
            return
        }
        isLoading = true
        
        let dateParts = date.components(separatedBy: " ")
        if dateParts.count < 2 {
            return
        }
        guard let day = Int(dateParts[1]) else {
            return
        }
        
        guard let monthIndex = englishMonthNames.firstIndex(of: dateParts[0]) else {
            return
        }
        
        Task {
            await getDataFor(month: monthIndex + 1, day: day)
        }
    }
    
    /// English month names
    /// Calendar can provide `monthSymbols` but they might not have been in English which the API requires
    var englishMonthNames = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
}
