import SwiftUI

struct HomePage: View {
    @State private var navigateToImageDisplay = false
    @State private var isPickerPresented = false
    @State private var selectedImage: UIImage?
    @StateObject private var viewModel = TextScannerViewModel()
    @State private var isTextViewPresented = false
    @State private var documentTitle: String = "Untitled Document"
    @State private var isSavedDocumentsPresented = false
    @State private var isLoading = false // Loading state variable
  //  @State private var Player: AVAudioPlayer?
    var body: some View {
        NavigationStack {
            ZStack {
                Color.offWhite
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Select the scanning method")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 50)
                    
                    // Navigation link to CameraView
                    NavigationLink(destination: CameraView(viewModel: viewModel, onCapturePhoto: {
                        if !viewModel.recognizedText.isEmpty {
                            isTextViewPresented = true
                        }
                    }), label: {
                        HStack {
                            Text("Take a photo")
                                .font(.headline)
                                .foregroundColor(.black)
                            Image(systemName: "camera.fill")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(50)
                        .background(Color.softy)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    })
                    .simultaneousGesture(TapGesture().onEnded {
                        //          playSound()
                       // print("FF")
                    })
                    
                    
                    
                    // Button to upload from album
                    Button(action: {
                        isPickerPresented = true // Trigger the photo picker
                    }) {
                        HStack {
                            Text("Upload from album")
                                .font(.headline)
                                .foregroundColor(.black)
                            Image(systemName: "photo.fill")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(50)
                        .background(Color.softy)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    }.simultaneousGesture(TapGesture().onEnded {
                        //      playSound()
                       // print("FF")
                    })
                    .sheet(isPresented: $isPickerPresented) {
                        PhotoPicker(selectedImage: $selectedImage)
                            .onChange(of: selectedImage) { newImage in
                                if let image = newImage {
                                    viewModel.processCapturedImage(image)
                                    print("Recognized Text: \(viewModel.recognizedText)") // Debugging output
                                    
                                    // Set navigation state immediately after image selection
                                    navigateToImageDisplay = true
                                }
                            }
                    }
                    
                    // Programmatic navigation to ImageDisplayView if an image is selected
                    NavigationLink(
                        destination: ImageDisplayView(image: selectedImage ?? UIImage(), recognizedText: viewModel.recognizedText, selectedImage: $selectedImage, isPickerPresented: $isPickerPresented),
                        isActive: $navigateToImageDisplay
                    ) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        isLoading = true // Set loading state to true
                        viewModel.saveDocument(title: documentTitle) // Save the document
                        isSavedDocumentsPresented = true // Navigate to saved documents view
                        isLoading = false // Set loading state to false after saving
                    }) {
                        if isLoading {
                            ProgressView() // Show loading indicator
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            HStack {
                                Text("Save Document")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Image(systemName: "document.fill")
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(50)
                            .background(Color.softy)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                        
                        
                    }
                }
                                      .navigationDestination(isPresented: $isSavedDocumentsPresented) {
                                          SavedDocumentsView(viewModel: viewModel)
                                      }
                                  }
                                  .padding()
                                  .navigationBarBackButtonHidden(true)
                              }
                          }
                      }
                  

#Preview {
    HomePage()
}
