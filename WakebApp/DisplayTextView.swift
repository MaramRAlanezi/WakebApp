
import SwiftUI

struct DisplayTextView: View {
    var recognizedText: String
    
    var body: some View {
        VStack {
         
            Text(recognizedText)
                .padding()
                .navigationTitle("Recognized Text")
                .navigationBarTitleDisplayMode(.inline)
         
            Spacer()
          
//           delete this
//
//            NavigationLink(destination: ReadingPage()) {
//                              Text("Confirm") // Text inside the button
//                                  .font(.title) // Adjust the font size for the button label
//                                  .frame(maxWidth: 150, minHeight: 30) // Full-width button with a minimum height
//                                  .background(Color("softy")) // Button background color
//                                  .foregroundColor(.black) // Text color
//                                  .cornerRadius(10) // Rounded corners for the button
//                                  .padding(.horizontal) // Adds some padding on the sides of the button
//                          }
                      }
                      .edgesIgnoringSafeArea(.bottom)// Optional: Ignore the bottom safe area if you want the button closer to the edge
    }
}


