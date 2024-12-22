//
//  HomePage.swift
//  WakebApp
//
//  Created by Maram Rabeh  on 17/12/2024.
//

import SwiftUICore
import SwiftUI

struct HomePage: View {
    @StateObject private var viewModel = HomePageViewModel()
    
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
                    // Add action for taking a photo
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
                    viewModel.openPhotoPicker()
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
                .sheet(isPresented: $viewModel.isPickerPresented) {
                    PhotoPicker(selectedImage: $viewModel.selectedImage)
                }
                
                Button(action: {
                    // Add action for saved documents
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

#Preview {
    HomePage()
}
