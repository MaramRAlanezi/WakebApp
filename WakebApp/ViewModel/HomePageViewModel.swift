//
//  Untitled.swift
//  WakebApp
//
//  Created by Maram Rabeh  on 22/12/2024.
//

import SwiftUI
import PhotosUI

class HomePageViewModel: ObservableObject {
    @Published var isPickerPresented = false
    @Published var selectedImage: UIImage? = nil
    
    func openPhotoPicker() {
        isPickerPresented = true
    }
    
    func handleImageSelection(_ image: UIImage?) {
        selectedImage = image
    }
}
