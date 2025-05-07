//
//  BookListView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import SwiftUI

struct BookList: View {
    @State private var viewModel = BookListViewModel(
        bookRepository: BookRepositoryImpl(openBDRepository: OpenBDRepositoryImpl())
    )
    let isSelectable: Bool
    let selectedHandler: ((Book) -> Void)?
    
    var body: some View {
        VStack {
            ForEach(viewModel.books, id: \.self) { book in
                if isSelectable {
                    Button {
                        selectedHandler?(book)
                    } label: {
                        makeCell(book: book)
                    }
                    .tint(.primary)
                } else {
                    makeCell(book: book)
                }
            }
        }
        .onAppear {
            viewModel.fetchBooks()
        }
    }
    
    init(isSelectable: Bool, selectedHandler: ((Book) -> Void)? = nil) {
        self.isSelectable = isSelectable
        self.selectedHandler = selectedHandler
    }
    
    private func makeCell(book: Book) -> some View {
        VStack(spacing: 16) {
            BookListCell(book: book)
            Divider()
                .scaleEffect(x: 1, y: 2)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    PreviewSupport.createPreviewContainer()
    return VStack {
        BookList(isSelectable: false)
        Spacer()
    }
}
