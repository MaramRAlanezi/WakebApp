//
//  RenameDocumentView.swift
//  WakebApp
//
//  Created by Diala Abdulnasser Fayoumi on 30/06/1446 AH.
//

import SwiftUI
struct RenameDocumentView: View {
    @Binding var document: SavedDocument?
    @Binding var newTitle: String
    var onRename: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rename Document")) {
                    TextField("New Document Title", text: $newTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationBarItems(leading: Button("Cancel") {
                document = nil // Clear the document
            }, trailing: Button("Rename") {
                onRename() // Call the rename closure
            })
            .navigationTitle("Rename")
        }
    }
}
