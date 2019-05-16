//
//  DataModel.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation

internal enum ButtonType: String, Codable {
    case email
    case share
}

internal struct ButtonModel: Codable {
    public var type: ButtonType
    public var email: String?
    public var label: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case email
        case label
    }
}

internal struct DataModel: Codable {
    public var title: String?
    public var button: ButtonModel?
    
    enum CodingKeys: String, CodingKey {
        case title = "#title"
        case button = "button"
    }
    
    public init?(map: [String: Any]) {
        self.mapping(map: map)
    }
    
    public mutating func mapping(map: [String: Any]) {
        title = map[CodingKeys.title.rawValue] as? String
        if let buttonData = map[CodingKeys.button.rawValue] as? [String: Any], let rawType = buttonData[ButtonModel.CodingKeys.type.rawValue] as? String {
            let email = buttonData[ButtonModel.CodingKeys.email.rawValue] as? String
            let label = buttonData[ButtonModel.CodingKeys.label.rawValue] as? String
            let type = ButtonType(rawValue: rawType)
            self.button = ButtonModel(type: type ?? ButtonType.share, email: email, label: label)
        }
    }
}
