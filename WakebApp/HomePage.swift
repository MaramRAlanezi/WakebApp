//
//  HomePage.swift
//  WakebApp
//
//  Created by Maram Rabeh  on 17/12/2024.
//

import SwiftUI
import PhotosUI

struct HomePage: View {
    @State private var isPickerPresented = false
       @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            Color.offWhite
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Select the scanning method")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 50)
                
                Button(action: {
                }) {
                    HStack {
                    
                        Text("Take a photo")
                            .font(.headline)
                            .foregroundColor(.black)
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(50)
                    .background(Color.lightGreen)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                
                Button(action: {
                    isPickerPresented = true
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
                    .background(Color.lightGreen)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                .sheet(isPresented: $isPickerPresented) {
                    PhotoPicker(selectedImage: $selectedImage)
                }
                
                Button(action: {
                }) {
                    HStack {
                        Text("Saved Documents")
                            .font(.headline)
                            .foregroundColor(.black)
                        Image(systemName: "doc.fill")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(50)
                    .background(Color.lightGreen)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                
            }
            .padding()
                  }
                  .navigationBarBackButtonHidden(true)
              }
          }

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image as? UIImage
                    }
                }
            }
        }
    }
}
#Preview {
    HomePage()
}
