//
//  LogsManager.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import Foundation
import RCache

enum LogActionType: String {
    case addKey = "Add Key"
    case removeKey = "Remove Key"
    case save = "Save"
    case read = "Read"
    case remove = "Remove"
    case clear = "Clear"
}

struct LogModel: Codable {
    let action: String
    let value: String
    let time: String
}

struct LogIdentifiableModel: Identifiable {
    let id = UUID()
    let action: String
    let value: String
    let time: String
    
    init(action: String, value: String, time: String) {
        self.action = action
        self.value = value
        self.time = time
    }
}

struct LogRootModel: Codable {
    let data: [LogModel]?
}

class LogManager {
    private static var _instance: LogManager?
    private static let lock = NSLock()
    
    private var localData: [LogModel] = []
    
    private init(){}
    
    internal static var instance: LogManager {
        if _instance == nil {
            lock.lock()
            defer {
                lock.unlock()
            }
            if _instance == nil {
                _instance = LogManager()
            }
        }
        return _instance!
    }
}

extension LogManager {
    func data() -> [LogModel]? {
        do {
            let logs = try RCache.common.read(type: LogRootModel.self, key: .logs)?.data
            
            if let logs = logs {
                localData = logs
            }
            
            return logs
        } catch {
            return nil
        }
    }
    
    func add(action: LogActionType, value: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        localData.append(
            LogModel(
                action: action.rawValue,
                value: value,
                time: dateFormatter.string(from: Date())
            )
        )
        
        do {
            try RCache.common.save(value: LogRootModel(data: localData), key: .logs)
        } catch {
            print(error)
        }
    }
}

extension Array where Element == LogModel {
    func toIdentifible() -> [LogIdentifiableModel] {
        return self.map({ LogIdentifiableModel(action: $0.action, value: $0.value, time: $0.time) })
    }
}
