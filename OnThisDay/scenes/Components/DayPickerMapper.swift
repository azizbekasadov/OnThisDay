//
//  DayPickerMapper.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import Foundation

final class DayPickerMapper {
    
    static func maxDays(for month: String) -> Int {
        guard let monthParsed = Month(rawValue: month) else {
            fatalError("Unable to parse inproper month key")
        }
        
        return self.getMaxDays(monthParsed)
    }
    
    private static func getMaxDays(_ month: Month) -> Int {
        switch month {
        case .february: return 29
        case .april, .june, .september, .november: return 30
        default: return 31
        }
    }
    
    enum Month: String {
        case january = "January"
        case february = "February"
        case march = "March"
        case april = "April"
        case may = "May"
        case june = "June"
        case july = "July"
        case august = "August"
        case september = "September"
        case october = "October"
        case november = "November"
        case december = "December"
    }
}
