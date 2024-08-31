//
//  SaveModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import Foundation
import RCache

enum DataType: String, CaseIterable {
    case data = "Data"
//    case codable = "Codable"
    case string = "String"
    case bool = "Boolean"
    case integer = "Integer"
    case array = "Array"
    case dictionary = "Dictionary"
    case double = "Double"
    case float = "Float"
    
    var isNumber: Bool {
        switch self {
        case .integer, .double, .float: true
        default: false
        }
    }
    
    var isUseTextField: Bool {
        switch self {
        case .bool, .array, .dictionary: false
        default: true
        }
    }
}

enum StorageType: String, CaseIterable {
    case common = "General Data"
    case credentials = "Credentials Data"
    
    var rCache: RCaching {
        switch self {
        case .common: RCache.common
        case .credentials: RCache.credentials
        }
    }
}
