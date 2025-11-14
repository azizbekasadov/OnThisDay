//
//  EventView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

import SwiftUI

struct EventView: View {
    var event: Event
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                TextView()
                LinksView()
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(width: 250.0)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.15), radius: 15)
        .id(event.id)
    }
    
    @ViewBuilder
    private func LinksView() -> some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
           Text("Related Links:")
                .font(.title2)
                .fontWeight(.medium)
            
            
            ForEach(event.links) { link in
                Link(link.title, destination: link.url)
                    .onHover { isInside in
                        isInside ? NSCursor.pointingHand.push() : NSCursor.pop()
                    }
            }
        }
    }
    
    @ViewBuilder
    private func TextView() -> some View {
        Text(event.year)
            .font(.title)
            .bold()
        Text(event.text)
            .font(.title3)
    }
}

#Preview {
    EventView(event: .sampleEvent)
}
