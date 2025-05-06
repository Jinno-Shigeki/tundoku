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
        NavigationStack(path: $router.path) {
            ReadingListView()
                .applyRouter()
        }
    }
}

#Preview {
    PreviewSupport.createPreviewContainer()
    return RootView()
}
