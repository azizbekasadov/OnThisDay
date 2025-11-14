//
//  DayDataSource.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Foundation

protocol DayDataSource {
    func getData(for day: Int, month: Int) async throws -> Day
}
