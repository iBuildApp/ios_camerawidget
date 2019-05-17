//
//  CameraViewController.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation
import IBACore
import IBACoreUI
import AVFoundation
import NextLevel
import Stevia
import PKHUD

class CameraViewController: BaseViewController, UINavigationControllerDelegate {
    // MARK: - Private properties
    /// Widget type indentifier
    private var type: String?
    
    /// Widger config data
    private var data: DataModel?
    
    private let cameraView = CameraView()
    
    // MARK: - Controller life cycle methods
    public convenience init(type: String?, data: DataModel?) {
        self.init()
        self.type = type
        self.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
        view.sv(cameraView)
        cameraView.top(0).bottom(0).left(0).right(0)
        
        NextLevel.shared.previewLayer.frame = UIScreen.main.bounds//cameraView.previewView.bounds
        cameraView.previewView.layer.addSublayer(NextLevel.shared.previewLayer)
        
        NextLevel.shared.photoDelegate = self
        NextLevel.shared.captureMode = .photo
        
        cameraView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        cameraView.cameraButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        cameraView.flipButton.addTarget(self, action: #selector(flipCamera), for: .touchUpInside)
    }
    
    @objc
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func takePhoto() {
        NextLevel.shared.capturePhoto()
    }
    
    @objc
    func flipCamera() {
        NextLevel.shared.flipCaptureDevicePosition()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.startCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NextLevel.shared.stop()
    }
    
    func startCamera() {
        if NextLevel.authorizationStatus(forMediaType: AVMediaType.video) == .authorized {
            do {
                try NextLevel.shared.start()
            } catch let error {
                print("NextLevel, failed to start camera session")
                print("Error: \(error)")
            }
        } else {
            NextLevel.requestAuthorization(forMediaType: AVMediaType.video) { (mediaType, status) in
                print("NextLevel, authorization updated for media \(mediaType) status \(status)")
                if NextLevel.authorizationStatus(forMediaType: AVMediaType.video) == .authorized {
                    do {
                        try NextLevel.shared.start()
                    } catch {
                        print("NextLevel, failed to start camera session")
                    }
                } else if status == .notAuthorized {
                    // gracefully handle when audio/video is not authorized
                    print("NextLevel doesn't have authorization for audio or video")
                }
            }
        }
    }
    
    func showImage(_ image: UIImage) {
        HUD.show(.progress)
        self.present(PreviewViewController(image: image, from: self, shareButton: data?.button), animated: true) {
            HUD.hide()
        }
    }
}

extension CameraViewController: NextLevelPhotoDelegate {
    func nextLevel(_ nextLevel: NextLevel, willCapturePhotoWithConfiguration photoConfiguration: NextLevelPhotoConfiguration) { }
    
    func nextLevel(_ nextLevel: NextLevel, didCapturePhotoWithConfiguration photoConfiguration: NextLevelPhotoConfiguration) { }
    
    func nextLevel(_ nextLevel: NextLevel, didProcessPhotoCaptureWith photoDict: [String: Any]?, photoConfiguration: NextLevelPhotoConfiguration) {
        if let dictionary = photoDict, let photoData = dictionary[NextLevelPhotoJPEGKey] {
            if let data = photoData as? Data, let image = UIImage(data: data) {
                self.showImage(image)
            }
        }
    }
    
    func nextLevel(_ nextLevel: NextLevel, didProcessRawPhotoCaptureWith photoDict: [String: Any]?, photoConfiguration: NextLevelPhotoConfiguration) {
        if let dictionary = photoDict, let photoData = dictionary[NextLevelPhotoJPEGKey] {
            if let data = photoData as? Data, let image = UIImage(data: data) {
                self.showImage(image)
            }
        }
    }
    
    func nextLevelDidCompletePhotoCapture(_ nextLevel: NextLevel) {
        
    }
    
    @available(iOS 11.0, *)
    func nextLevel(_ nextLevel: NextLevel, didFinishProcessingPhoto photo: AVCapturePhoto) {
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error while generating image from photo capture data.")
            return
        }
        
        guard let image = UIImage(data: imageData) else {
            print("Unable to generate UIImage from image data.")
            return
        }
        
        self.showImage(image)
    }
}
