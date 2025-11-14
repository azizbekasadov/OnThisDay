//
//  DayDataSourceRepository.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Foundation
import OTDStorage

protocol DayDataSourceRepositoryProto {
    func getData(for day: Int, month: Int) async throws -> Day
}

final class DayDataSourceRepository: DayDataSourceRepositoryProto {
    enum SourceType {
        case remote
        case local
    }
    
    private var sourceType: SourceType = .local
    
    private let remote: DayDataSource
    private let local: DayDataSource
    
    private let storage: StorageService
    
    init(
        remote: DayDataSource,
        local: DayDataSource,
        storage: StorageService
    ) {
        self.remote = remote
        self.local = local
        self.storage = storage
    }
    
    func getData(for day: Int, month: Int) async throws -> Day {
        // check current date and month
        do {
            let localData = try await local.getData(for: day, month: month)
            return localData
        } catch LocalDayDataSource.LocalDayDataSourceError.noObjectFound {
            return try await getRemoteData(for: day, month: month)
        } catch {
            throw error
        }
    }
    
    // cleaning up cache for the new date
    private func getRemoteData(for day: Int, month: Int) async throws -> Day {
        let remoteData = try await remote.getData(for: day, month: month)
        // storing locally
        let entity = storage.store(DayEntity.self)
        entity.configure(with: remoteData, for: day, with: month)
        storage.save()
        
        return remoteData
    }
}
