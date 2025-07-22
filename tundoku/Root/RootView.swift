//
//  ContentView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var router = Router.shared
    
    var body: some View {
        TabView {
            NavigationStack(path: $router.path) {
                ReadingListView()
                    .applyRouter()
            }
            .tabItem {
                Label("読書一覧", systemImage: "book")
            }
            
            
            Text("リマインダー")
                .tabItem {
                    Label("リマインダー", systemImage: "calendar")
                }

            NavigationStack(path: $router.path) {
                SettingView()
            }
            .tabItem {
                Label("設定", systemImage: "gear")
            }
        }
    }
}

#Preview {
    PreviewSupport.createPreviewContainer()
    return RootView()
}
