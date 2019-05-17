//
//  DataModel.swift
//  CameraModule
//
//  Created by Anton Boyarkin on 15/05/2019.
//

import Foundation

public enum ShareType: String, Codable {
    case email
    case share
}

public struct ShareButtonModel: Codable {
    public var type: ShareType
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
    public var button: ShareButtonModel?
    
    enum CodingKeys: String, CodingKey {
        case title = "#title"
        case button = "button"
    }
    
    public init?(map: [String: Any]) {
        self.mapping(map: map)
    }
    
    public mutating func mapping(map: [String: Any]) {
        title = map[CodingKeys.title.rawValue] as? String
        if let buttonData = map[CodingKeys.button.rawValue] as? [String: Any], let rawType = buttonData[ShareButtonModel.CodingKeys.type.rawValue] as? String {
            let email = buttonData[ShareButtonModel.CodingKeys.email.rawValue] as? String
            let label = buttonData[ShareButtonModel.CodingKeys.label.rawValue] as? String
            let type = ShareType(rawValue: rawType)
            self.button = ShareButtonModel(type: type ?? ShareType.share, email: email, label: label)
        }
    }
}
