//
//  CameraModuleRouter.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation
import AppBuilderCore
import AppBuilderCoreUI

public enum CameraModuleRoute: Route {
    case root
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
        var options = TransitionOptions(animated: true)
        options.type = .modal
        return RouteTransition(module: generateRootViewController(), options: options)
    }
    
    public override func rootTransition() -> RouteTransition {
        return self.prepareTransition(for: .root)
    }
}
