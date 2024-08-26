//
//  KeyModel.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 26/08/24.
//

import Foundation

struct KeyModel: Identifiable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
