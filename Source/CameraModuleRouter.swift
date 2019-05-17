//
//  CameraModuleRouter.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation
import IBACore
import IBACoreUI

public enum CameraModuleRoute: Route {
    case root
    case preview(image: UIImage, from: UIViewController?, shareButton: ShareButtonModel?)
}

public class CameraModuleRouter: BaseRouter<CameraModuleRoute> {
    var module: CameraModule?
    init(with module: CameraModule) {
        self.module = module
    }
    
    public override func generateRootViewController() -> BaseViewControllerType {
        return CameraViewController(type: module?.config?.type, data: module?.data)
    }
    
    public override func prepareTransition(for route: CameraModuleRoute) -> RouteTransition {
        switch route {
        case .root:
            var options = TransitionOptions(animated: true)
            options.type = .modal
            return RouteTransition(module: generateRootViewController(), options: options)
        case .preview(let image, let from, let shareButton):
            var options = TransitionOptions(animated: true)
            options.type = .modal
            return RouteTransition(module: PreviewViewController(image: image, from: from, shareButton: shareButton), options: options)
        }
    }
    
    public override func rootTransition() -> RouteTransition {
        return self.prepareTransition(for: .root)
    }
}
