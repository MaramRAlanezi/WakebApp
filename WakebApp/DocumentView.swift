
import SwiftUI

struct DocumentView: View {
    var document: SavedDocument

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(document.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Directly display the extracted text
                Text(document.content) // Assuming 'content' holds the recognized text
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
            }
            .padding()
            .navigationTitle("Document Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
