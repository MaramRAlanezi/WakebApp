import SwiftUI



// ReadingPage struct
struct ReadingPage: View {
    @State private var fontSize: Double = 14
    @State private var wordSpacing: Double = 1.5
    @State private var lineSpacing: Double = 5.0
    @State private var showSettings = false
    @State private var pageBackgroundColor: Color = Color("offwhite")
    @State private var selectedFont: String = "Arial"
    
    @State private var modifiedText: String // Editable text
    @State private var navigateToDocumentView = false // State for navigation
    
    var extractedText: String  // Text passed from ExtractedText
    
    init(extractedText: String) {
        self.extractedText = extractedText
        self.modifiedText = extractedText // Initialize modifiedText
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                pageBackgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Display modifiedText instead of extractedText
                        Text(modifiedText)
                            .font(.custom(selectedFont, size: fontSize))
                            .kerning(wordSpacing)
                            .lineSpacing(lineSpacing) // Apply line spacing here
                            .padding([.leading, .trailing])
                    }
                    .padding()
                }
                .scrollIndicators(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: HomePage()) {
                        HStack {
                            Image(systemName: "chevron.left").resizable().frame(width: 20, height: 20)
                            Text("Back")
                        }
                        .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings.toggle() }) {
                        HStack {
                            Text("Settings").foregroundColor(.black)
                            Image(systemName: "gearshape.fill").resizable().foregroundColor(.black)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { saveDocument() }) {
                        Text("Save").foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: DocumentView(document: SavedDocument(title: "Saved Document", content: modifiedText)), isActive: $navigateToDocumentView) {
                        Button(action: { navigateToDocumentView = true }) {
                            Text("View Document").foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsSheetView(
                fontSize: $fontSize,
                wordSpacing: $wordSpacing,
                lineSpacing: $lineSpacing,
                pageBackgroundColor: $pageBackgroundColor,
                selectedFont: $selectedFont
            )
            .presentationDetents([.height(400)])
            .presentationDragIndicator(.visible)
            .presentationBackground(.softy)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func saveDocument() {
        let textToSave = modifiedText
        let fileName = getDocumentsDirectory().appendingPathComponent("savedDocument.txt")
        
        do {
            try textToSave.write(to: fileName, atomically: true, encoding: .utf8)
            print("Document saved to \(fileName)")
        } catch {
            print("Failed to save document: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ReadingPage_Previews: PreviewProvider {
    static var previews: some View {
        ReadingPage(extractedText: "Sample extracted text here هذا نص عربي ...")
            .environment(\.locale, .init(identifier: "ar"))
    }
}
