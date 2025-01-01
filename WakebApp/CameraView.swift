//
//  CameraView.swift
//  WakebApp
//
//  Created by Diala Abdulnasser Fayoumi on 16/06/1446 AH.
//
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: TextScannerViewModel
    var onCapturePhoto: (() -> Void)?

    class Coordinator: NSObject {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func capturePhoto() {
            parent.onCapturePhoto?()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> ViewController {
        let cameraViewController = ViewController(viewModel: viewModel)
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Handle updates if needed
    }
}
