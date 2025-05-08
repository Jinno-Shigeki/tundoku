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
                Section {
                    Button {
                            
                    } label: {
                        Label("一覧", systemImage: "book")
                            .font(.caption)
                            .foregroundStyle(.primary)
                            .labelStyle(.titleAndIcon)
                    }
                } header: {
                    Text("")
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
