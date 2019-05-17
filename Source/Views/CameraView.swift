//
//  CameraView.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import UIKit
import IBACoreUI
import Stevia

class CameraView: UIView {
    
    let previewView = UIView()
    
    let closeButton = UIButton()
    let cameraButton = UIButton()
    let flipButton = UIButton()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        sv(
            previewView,
            closeButton,
            flipButton,
            cameraButton
        )
        
        // MARK: Layout 📐
        previewView.top(0).bottom(0).left(0).right(0)
        closeButton.bottom(40).height(50).left(30)
        closeButton.Width == closeButton.Height
        cameraButton.bottom(40).centerHorizontally().height(50).width(100)
        flipButton.bottom(40).height(50).width(80).right(30)
        
        // MARK: Styling 🎨
        previewView.backgroundColor = UIColor.black
        backgroundColor = UIColor.black
        closeButton.backgroundColor = UIColor.white
        closeButton.layer.cornerRadius = 25
        cameraButton.backgroundColor = UIColor.white
        cameraButton.layer.cornerRadius = 25
        flipButton.backgroundColor = UIColor.white
        flipButton.layer.cornerRadius = 25
        
        // MARK: Content 🖋
        closeButton.setImage(getCoreUIImage(with: "loginScreenCloseButton"), for: .normal)
        cameraButton.setImage(getCoreUIImage(with: "mTP_cameraButton"), for: .normal)
        flipButton.setImage(getCoreUIImage(with: "mTP_switchButton"), for: .normal)
    }
}
