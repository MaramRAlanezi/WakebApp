//

import SwiftUI

struct ExtractedText: View {
    var recognizedText: String

    var body: some View {
        ZStack {
            Color.offWhite
                .ignoresSafeArea()
            VStack {
                Text(recognizedText)  // Display the extracted text
                    .padding()
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .navigationTitle("Recognized Text")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true) 
                // Button to navigate to ReadingPage
                NavigationLink(destination: ReadingPage(extractedText: recognizedText)) {
                    Text("Confirm")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.softy)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
      
}

//import SwiftUI
//
//struct ExtractedText: View {
//    var recognizedText: String  // Ensure this matches what you're trying to pass
//
//    var body: some View {
//        ScrollView {
//            Text(recognizedText)
//                .padding()
//                .navigationTitle("Extracted Text")
//                .navigationBarTitleDisplayMode(.inline)
//            NavigationLink(destination: ReadingPage(extractedText: recognizedText)) {
//                Text("Confirm")
//                    .font(.title2)
//                    .padding()
//                    .foregroundColor(.black)
//                    .background(Color.softy)
//                    .cornerRadius(10)
//            }
//       
//        
//        }
//    }
//}
//import SwiftUI
//
//struct ExtractedText: View {
//    var recognizedText: String
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                if recognizedText.isEmpty {
//                    Text("No text extracted.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    Text(recognizedText)
//                        .padding()
//                    
//                    // Navigation button to ReadingPage
//                    NavigationLink(destination: ReadingPage(extractedText: recognizedText)) {
//                        Text("Go to Reading Page")
//                            .font(.title2)
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(Color.blue) // Change to your desired color
//                            .cornerRadius(10)
//                    }
//                    .padding(.top)
//                }
//            }
//            .navigationTitle("Extracted Text")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
