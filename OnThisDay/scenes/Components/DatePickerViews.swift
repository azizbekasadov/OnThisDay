//
//  DatePickerViews.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import SwiftUI

struct OTDDatePickerView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                DatePicker(
                    "Field",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.field)
                
                DatePicker(
                    "Graphical",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
            .padding()
            
            Text(selectedDate.description)
                .padding([.bottom, .horizontal])
        }
    }
}

#Preview {
    OTDDatePickerView()
}
