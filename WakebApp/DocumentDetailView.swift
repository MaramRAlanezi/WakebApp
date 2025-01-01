//
//  DocumentDetailView.swift
//  WakebApp
//
//  Created by Diala Abdulnasser Fayoumi on 29/06/1446 AH.
//
import SwiftUI

struct DocumentDetailView: View {
    var extractedText: String // Accept extracted text
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Document Content")
                .font(.headline)
                .padding()
            ScrollView {
                Text(extractedText) // Display the extracted text
                    .padding()
            }
        }
        .navigationTitle("Document Content")
    }
}
