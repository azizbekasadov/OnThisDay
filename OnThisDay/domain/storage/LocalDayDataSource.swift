//
//  LocalDayDataSource.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Foundation
import OTDStorage

final class LocalDayDataSource: DayDataSource {
    enum LocalDayDataSourceError: Error {
        case noObjectFound
    }
    
    private let storageService: StorageService
    
    init(storageService: StorageService) {
        self.storageService = storageService
    }
    
    func getData(for day: Int, month: Int) async throws -> Day {
        let data = storageService.fetch(DayEntity.self).filter {
            $0.syncDate == "\(day)-\(month)"
        }
        
        guard let first = data.first else {
            throw LocalDayDataSourceError.noObjectFound
        }
        
        return Day(data: first)
    }
}
