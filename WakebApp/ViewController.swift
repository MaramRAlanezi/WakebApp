import UIKit
import AVFoundation

class ViewController: UIViewController {
    var viewModel: TextScannerViewModel
    private var captureSession: AVCaptureSession!
    private var photoOutput: AVCapturePhotoOutput!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    private var capturedImageView: UIImageView? // To display the captured image
    private var isPhotoCaptured = false // Track if a photo has been captured

    init(viewModel: TextScannerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        checkCameraPermissions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func checkCameraPermissions() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

        if cameraAuthorizationStatus == .authorized {
            setupCamera()
        } else if cameraAuthorizationStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                } else {
                    print("Camera access denied.")
                }
            }
        } else {
            print("Camera access previously denied.")
        }
    }

    private func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Error creating video input: \(error)")
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Could not add video input.")
            return
        }

        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            print("Could not add photo output.")
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
        
        setupZoomGesture() // Add zoom gesture setup
    }

    private func setupZoomGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        view.addGestureRecognizer(pinchGesture)
    }

    @objc private func handlePinch(gesture: UIPinchGestureRecognizer) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            try device.lockForConfiguration()
            let newScale = device.videoZoomFactor * gesture.scale
            device.videoZoomFactor = min(max(newScale, 1.0), device.activeFormat.videoMaxZoomFactor)
            device.unlockForConfiguration()
        } catch {
            print("Error locking configuration: \(error)")
        }

        // Reset the scale to 1.0 for the next pinch
        gesture.scale = 1.0
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        previewLayer.frame = view.layer.bounds
    }

    @objc func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    @objc func retakePhoto() {
        // Reset the camera and remove previously captured image
        isPhotoCaptured = false
        capturedImageView?.removeFromSuperview()
        capturedImageView = nil
        captureSession.startRunning()
    }
   
    @objc func savePhoto() {
        guard let image = capturedImageView?.image else { return }
        
        // Extract text from the captured image
        viewModel.extractText(from: image)

        // Navigate to the new view controller to display the extracted text
        let textDisplayVC = TextDisplayViewController(viewModel: viewModel)
        navigationController?.pushViewController(textDisplayVC, animated: true)
    }

    private func createCaptureButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: (view.bounds.width - 70) / 2, y: view.bounds.height - 100, width: 70, height: 70))
        button.layer.cornerRadius = 35
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        return button
    }

    private func createSaveButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 90, y: view.bounds.height - 100, width: 80, height: 40))
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .focused)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
        return button
    }

    private func createRetakeButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 20, y: view.bounds.height - 100, width: 80, height: 40)) // Positioned at bottom-left
        button.setTitle("Retake", for: .normal)
        button.setTitleColor(.white, for: .focused)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(retakePhoto), for: .touchUpInside)
        return button
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addSubview(createCaptureButton())
        
        // If an image is captured, show the buttons to save or retake
        if isPhotoCaptured {
            view.addSubview(createSaveButton())
            view.addSubview(createRetakeButton())
        }
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            print("Error processing photo.")
            return
        }

        // Display the captured image
        capturedImageView = UIImageView(image: image)
        capturedImageView?.contentMode = .scaleAspectFit
        capturedImageView?.frame = view.bounds
        view.addSubview(capturedImageView!)
        
        // Update the photo state
        isPhotoCaptured = true
        
        // Show save and retake buttons
        view.addSubview(createSaveButton())
        view.addSubview(createRetakeButton())
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }

        // Handle successful capture
        photoOutput(output, didFinishProcessingPhoto: photo)
    }
}
