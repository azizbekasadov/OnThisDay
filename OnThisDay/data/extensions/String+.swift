//
//  String+.swift
//  OnThisDay
//
//  Created by Azizbek Asadov on 14.11.2025.
//

#if canImport(AppKit)
import AppKit
import Foundation

extension String {
    /// a decoded string with html tags being parsed
    var decoded: String {
        let attrtributedString = try? NSAttributedString(
            data: Data(utf8),
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
        
        return attrtributedString?.string ?? self
    }
}
#endif
