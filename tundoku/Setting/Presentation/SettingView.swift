//
//  SettingView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/08.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Form {
                Section("設定") {
                    Button {
                            
                    } label: {
                        Label("一覧", systemImage: "book")
                    }
                }
                .tint(.primary)
                
                Section("アプリ情報") {
                    Label("バージョン 1.0.0", systemImage: "info.circle")
                    
                    Button {
                        // Webサイトや利用規約へ
                    } label: {
                        Label("利用規約", systemImage: "doc.plaintext")
                    }
                }
                .tint(.primary)
            }
        }
        .background(.gray.opacity(0.1))
        .navigationTitle("設定")
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
