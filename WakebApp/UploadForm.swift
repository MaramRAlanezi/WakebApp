////
////  UploadForm.swift
////  WakebApp
////
////  Created by Maram Rabeh  on 19/12/2024.
////
//
//import SwiftUI
//import PhotosUI
//
//struct UploadForm: View {
//    @Environment(\.presentationMode) var presentationMode  // For back navigation
//    @State private var selectedPhoto: PhotosPickerItem? = nil
//    @State private var selectedPhotoData: Data? = nil
//   
//    var recipeToEdit: Recipe? // Optional recipe for edit mode
//
//    init(viewModel: RecipeIngredientViewModel, recipeToEdit: Recipe? = nil) {
//        self.viewModel = viewModel
//        self.recipeToEdit = recipeToEdit
//    }
//
//    var body: some View {
//        ZStack {
//            NavigationView {
//                ScrollView {
//                    VStack {
//                        
//                    //MARK:  PhotosPicker for uploading/changing photo
//                        PhotosPicker(
//                            selection: $selectedPhoto,
//                            matching: .images,
//                            photoLibrary: .shared()
//                        ) {
//                            ZStack {
//                                Rectangle()
//                                    .fill(Color.gray.opacity(0.3))
//                                    .frame(width: 410, height: 181)
//                                    .cornerRadius(10)
//                                    .padding()
//                                    .overlay(
//                                        Rectangle()
//                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [7, 5]))
//                                    .foregroundColor(Color("AccentColor"))
//                                    .padding()
//                                    )
//                                //MARK: if condtion to check if the user selcet a photo or not
//                                if let selectedPhotoData,
//                                   let uiImage = UIImage(data: selectedPhotoData) {
//                                    Image(uiImage: uiImage)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 410, height: 181)
//                                        .cornerRadius(10)
//                                } else {
//                                    VStack {
//                                        Image(systemName: "photo.badge.plus")
//                                            .font(.system(size: 60))
//                                        Text("Upload Photo")
//                                            .foregroundColor(.uploadphoto)
//                                            .font(.headline)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.top)
//                        //MARK: converting the photo into data to dispaly it to the user in the view
//                        .task(id: selectedPhoto) {
//                            if let selectedPhoto {
//                                Task {
//                                    if let data = try? await selectedPhoto.loadTransferable(type: Data.self) {
//                                        await MainActor.run {
//                                            selectedPhotoData = data
//                                            viewModel.newRecipeImage = data  // Pass image data to viewModel
//                                        }
//                                    }
//                                }
//                            }
//                        }
