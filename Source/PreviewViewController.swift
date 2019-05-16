//
//  PreviewViewController.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation
import AppBuilderCore
import AppBuilderCoreUI
import Stevia
import MessageUI

class PreviewViewController: UIViewController {
    
    private var previewImage: UIImage?
    private var rootController: UIViewController?
    private var shareButton: ButtonModel?
    
    var v: PreviewView!
    
    override func loadView() {
        v = PreviewView(shareButtonTitle: shareButton?.type == .email ? shareButton?.label : nil)
        view = v
    }
    
    public convenience init(image: UIImage, from rootController: UIViewController? = nil, shareButton: ButtonModel? = nil ) {
        self.init()
        self.previewImage = image
        self.rootController = rootController
        self.shareButton = shareButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v.imageView.image = previewImage
        v.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        v.retakeButton.addTarget(self, action: #selector(retakePhoto), for: .touchUpInside)
        v.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
    }
    
    @objc
    func close() {
        self.dismiss(animated: false) {
            self.rootController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func retakePhoto() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func share() {
        if let image = previewImage {
            if shareButton?.type == .email, let email = shareButton?.email {
                AppCoreServices.showMailComposer(with: [email], subject: Localization.Camera.Share.Email.subject, body: Localization.Camera.Share.Email.body, attachment: MailAttachment(image: image), for: self)
            } else {
                let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: {})
            }
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension PreviewViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            self.showAlertController(title: nil, message: Localization.Email.Message.success, buttonTitle: Localization.Common.Text.ok)
        case .failed:
            self.showAlertController(title: nil, message: Localization.Email.Message.Error.title, buttonTitle: Localization.Common.Text.ok)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
