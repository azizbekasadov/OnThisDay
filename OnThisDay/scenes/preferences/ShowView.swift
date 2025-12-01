//
//  ShowView.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import SwiftUI

struct ShowView: View {
    @AppStorage(kShowBirths) var showBirths = true
    @AppStorage(kShowDeaths) var showDeaths = true
    @AppStorage(kShowTotalsMainView) var showTotals = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Show Births", isOn: $showBirths)
            Toggle("Show Deaths", isOn: $showDeaths)
            Toggle("Show Totals", isOn: $showTotals)
        }
    }
}

#Preview {
    ShowView()
}
