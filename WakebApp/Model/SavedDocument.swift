//
//  SavedDocument.swift
//  demo app
//
//  Created by Reuof on 17/12/2024.
//

import Foundation

struct SavedDocument: Identifiable {
    var id = UUID()  // Unique identifier for each document
    var name: String
    var savedDate: Date
    var content: String
}
