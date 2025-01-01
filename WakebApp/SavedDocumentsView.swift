//
//  SavedDocumentsView.swift
//  WakebApp
//
//  Created by Diala Abdulnasser Fayoumi on 30/06/1446 AH.
//
import SwiftUI
struct SavedDocumentsView: View {
    @ObservedObject var viewModel: TextScannerViewModel
    @State private var showRenameSheet = false
    @State private var documentToRename: SavedDocument?
    @State private var newDocumentTitle: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.savedDocuments) { document in
                    HStack {
                        NavigationLink(destination: DocumentView(document: document)) {
                            Text(document.title) // Display the document title
                        }
                        Spacer()
                        // Rename Button
                        Button(action: {
                            documentToRename = document
                            newDocumentTitle = document.title // Pre-fill the text field
                            showRenameSheet = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        // Delete Button
                        Button(action: {
                            viewModel.deleteDocument(id: document.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle("Saved Documents")
            .sheet(isPresented: $showRenameSheet) {
                RenameDocumentView(document: $documentToRename, newTitle: $newDocumentTitle, onRename: {
                    if let document = documentToRename {
                        viewModel.renameDocument(id: document.id, newTitle: newDocumentTitle)
                    }
                    showRenameSheet = false
                })
            }
        }
    }
}
