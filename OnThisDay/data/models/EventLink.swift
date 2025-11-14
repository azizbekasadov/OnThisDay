//
//  EventLink.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import Foundation

struct EventLink: Decodable, Identifiable {
    let id: UUID
    let title: String
    let url: URL
}

extension EventLink {
    init(data: EventLinkEntity) {
        self.id = data.id
        self.title = data.title
        self.url = data.url
    }
}
