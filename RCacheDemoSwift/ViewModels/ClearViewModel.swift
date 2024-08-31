//
//  ClearViewModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI
import RCache

class ClearViewModel: ObservableObject {
    func clear(for type: ClearType) {
        switch type {
        case .common:
            RCache.common.clear()
        case .credentials:
            RCache.credentials.clear()
        case .all:
            RCache.clear()
        }
    }
    
    private func addToLog(for type: ClearType) {
        LogManager.instance.add(action: .clear, value: "Clear \(type.rawValue)")
    }
}
