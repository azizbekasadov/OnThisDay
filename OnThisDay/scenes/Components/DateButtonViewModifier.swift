//
//  DateButtonViewModifier.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import Foundation
import SwiftUI

struct DateButtonViewModifier: ViewModifier {
    var selected: Bool
    
    func body(content: Content) -> some View {
        if selected {
            content
                .buttonStyle(.borderedProminent)
        } else {
            content
        }
    }
}
