//
//  BookSelectorView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import SwiftUI

struct BookSelectorView: View {
    private var router: Router = .shared
    
    var body: some View {
        ScrollView {
            BookList(isSelectable: true) { book in
                router.push(.readingRegister(book: book))
            }
            .padding(.top, 24)
        }
        .navigationTitle(Text("本を選択"))
    }
}

#Preview {
    PreviewSupport.createPreviewContainer()
    return NavigationStack {
        BookSelectorView()
    }
}
