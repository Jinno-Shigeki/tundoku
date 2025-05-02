//
//  ContentView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var router = Router.shared
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ReadingListView()
                .toolbar {
                    ToolbarItem {
                        Button {
                            router.push(.bookRegister)
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
                .applyRouter()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
