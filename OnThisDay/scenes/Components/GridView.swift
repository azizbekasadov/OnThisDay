//
//  GridView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import SwiftUI
import Foundation

struct GridView: View {
    var event: [Event]
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 250, maximum: 250), spacing: 20)]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(event) { event in
                    EventView(event: event)
                        .frame(height: 350, alignment: .topLeading)
                        .border(.secondary, width: 0.5)
                        .padding(.bottom, 5)
                        .background()
                        .clipped()
                        .shadow(color: .primary.opacity(0.3), radius: 3, x: 3, y: 3)
                }
            }
        }
        .padding(.vertical)
        .scrollClipDisabled()
    }
}

#Preview {
    GridView(event: [.sampleEvent, .sampleEvent, .sampleEvent])
        .padding(.vertical)
        .frame(width: ((250 + 15) * 3), height: 400)
}
