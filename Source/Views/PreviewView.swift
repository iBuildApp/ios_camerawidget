//
//  PreviewView.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import UIKit
import IBACore
import IBACoreUI
import PinLayout
import FlexLayout

class PreviewView: UIView {
    let imageView = UIImageView()
    
    let closeButton = UIButton()
    let retakeButton = UIButton()
    let shareButton = UIButton()
    
    convenience init(shareButtonTitle: String? = nil) {
        self.init(frame: CGRect.zero)
        
        // MARK: Layout 📐
        flex.define { flex in
            flex.addItem(imageView).position(.absolute).top(30).bottom(80).left(0).right(0)
            flex.addItem(closeButton).position(.absolute).left(20).bottom(20).height(50).aspectRatio(1)
            flex.addItem().position(.absolute).alignItems(.center).bottom(0).right(0).height(50).direction(.rowReverse).margin(20).define({ flex in
                flex.addItem(shareButton).height(40).marginLeft(8)
                flex.addItem(retakeButton).height(40)
            })
        }
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flex.layout()
    }
}
