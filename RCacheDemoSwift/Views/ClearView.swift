//
//  ClearView.swift
//  RCacheDemoSwift
//
//  Created by Rahmat Trinanda Pramudya Amar on 31/08/24.
//

import SwiftUI

struct ClearView: View {
    @StateObject private var clearViewModel = ClearViewModel()
    
    @State private var clearType: ClearType = .common
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        VStack {
            HStack {
                Text("Clear Type:")
                Spacer()
                Picker("Clear Type", selection: $clearType) {
                    ForEach(ClearType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Spacer()
            
            
            Button(action: submit) {
                HStack {
                    Spacer()
                    Text("Clear")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.vertical)
            }
            .background(.blue)
            .clipShape(.buttonBorder)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("RCache: Clear")
        .navigationBarTitleDisplayMode(.inline)
        .toastView(toast: $toast)
    }
    
    func submit() {
        clearViewModel.clear(for: clearType)
        toast = Toast(style: .info, message: "Success Clear \(clearType.rawValue)")
    }
}
