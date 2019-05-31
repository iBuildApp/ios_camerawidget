//
//  CameraView.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import UIKit
import IBACoreUI
import PinLayout
import FlexLayout

class CameraView: UIView {
    
    let previewView = UIView()
    
    let closeButton = UIButton()
    let cameraButton = UIButton()
    let flipButton = UIButton()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // MARK: Layout 📐
        flex.define { flex in
            flex.addItem(previewView).position(.absolute).height(100%).width(100%)
            flex.addItem().position(.absolute).bottom(0).right(0).left(0).height(50).direction(.row).justifyContent(.spaceBetween).margin(20).define({ flex in
                flex.addItem(closeButton).left(0).top(0).bottom(0).aspectRatio(1)
                flex.addItem(cameraButton).position(.absolute).left(50%).marginLeft(-50).top(0).bottom(0).height(50).width(100)
                flex.addItem(flipButton).right(0).top(0).bottom(0).width(80)
            })
        }
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flex.layout()
    }
}
