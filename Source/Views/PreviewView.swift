//
//  PreviewView.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import UIKit
import AppBuilderCore
import AppBuilderCoreUI
import Stevia

class PreviewView: UIView {
    let imageView = UIImageView()
    
    let closeButton = UIButton()
    let retakeButton = UIButton()
    let shareButton = UIButton()
    
    convenience init(shareButtonTitle: String? = nil) {
        self.init(frame: CGRect.zero)
        
        sv(
            imageView,
            closeButton,
            retakeButton,
            shareButton
        )
        
        // MARK: Layout 📐
        imageView.top(30).bottom(80).left(0).right(0)
        closeButton.bottom(40).height(50).left(20)
        closeButton.Width == closeButton.Height
        retakeButton.height(40)
        shareButton.height(40)
        
        align(horizontally: retakeButton-20-shareButton-|)
        
        closeButton.CenterY == closeButton.CenterY
        closeButton.CenterY == shareButton.CenterY
        
        // MARK: Styling 🎨
        backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        closeButton.backgroundColor = UIColor.white
        closeButton.layer.cornerRadius = 25
        retakeButton.backgroundColor = UIColor.white
        retakeButton.layer.cornerRadius = 20
        retakeButton.setTitleColor(.black, for: .normal)
        retakeButton.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        shareButton.backgroundColor = UIColor.white
        shareButton.layer.cornerRadius = 20
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        
        // MARK: Content 🖋
        closeButton.setImage(getCoreUIImage(with: "loginScreenCloseButton"), for: .normal)
        retakeButton.setImage(getCoreUIImage(with: "mTP_cameraButton"), for: .normal)
        retakeButton.setTitle(Localization.Camera.Button.retake, for: .normal)
        if let name = shareButtonTitle {
            shareButton.setTitle(name, for: .normal)
        } else {
            shareButton.setTitle(Localization.Common.Text.share, for: .normal)
        }
    }
}
