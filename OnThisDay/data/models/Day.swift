//
//  Day.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Foundation

struct Day: Decodable {
    let date: String
    let data: [String: [Event]]
    
    let displayDate: String
    let events: [Event]
    let births: [Event]
    let deaths: [Event]
    
    enum CodingKeys: CodingKey {
        case date
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.data = try container.decode([String : [Event]].self, forKey: .data)
        
        // computed vars
        self.displayDate = date.replacingOccurrences(of: "_", with: " ")
        self.events = data[EventType.events.rawValue] ?? []
        self.births = data[EventType.births.rawValue] ?? []
        self.deaths = data[EventType.deaths.rawValue] ?? []
    }
    
    init(date: String, data: [String: [Event]]) {
        self.data = data
        self.date = date
        
        // computed vars
        self.displayDate = date.replacingOccurrences(of: "_", with: " ")
        self.events = data[EventType.events.rawValue] ?? []
        self.births = data[EventType.births.rawValue] ?? []
        self.deaths = data[EventType.deaths.rawValue] ?? []
    }
}

// convenience init

extension Day {
    init(data: DayEntity) {
        self.date = data.date
        let res = Dictionary(grouping: data.data) { item in
            item.identifier
        }
        
        self.data = res.compactMapValues { val in
            val.reduce([], { $0 + $1.events.compactMap(Event.init)})
        }
        
        // computed vars
        self.displayDate = date.replacingOccurrences(of: "_", with: " ")
        self.events = self.data[EventType.events.rawValue] ?? []
        self.births = self.data[EventType.births.rawValue] ?? []
        self.deaths = self.data[EventType.deaths.rawValue] ?? []
    }
}
