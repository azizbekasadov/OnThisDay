//
//  ClientAPIService.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Foundation
import OTDNetwork

internal let baseURLString = "https://today.zenquotes.io/api/"

final class ClientAPIService: NSObject, DayDataSource {
    
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getData(for day: Int, month: Int) async throws -> Day {
        let urlString = baseURLString + "\(month)/\(day)"
        return try await networking.fetchData(from: urlString)
    }
}
