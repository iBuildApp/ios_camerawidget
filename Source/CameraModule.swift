//
//  CameraModule.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation
import AppBuilderCore
import AppBuilderCoreUI

public class CameraModule: BaseModule, ModuleType {
    public var moduleRouter: AnyRouter { return router }

    private var router: CameraModuleRouter!
    internal var config: WidgetModel?
    internal var data: DataModel?

    public override class func canHandle(config: WidgetModel) -> Bool {
        if config.type == "takepicture" {
            return true
        }
        return false
    }

    public required init() {
        print("\(type(of: self)).\(#function)")
        super.init()
        router = CameraModuleRouter(with: self)
    }

    public func setConfig(_ model: WidgetModel) {
        self.config = model
        if let data = model.data, let dataModel = DataModel(map: data) {
            self.data = dataModel
        } else {
            print("Error parsing!")
        }
    }
}
