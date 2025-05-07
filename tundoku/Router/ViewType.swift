//
//  ViewType.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

enum ViewType: Hashable {
    case bookRegister
    case bookSelector
    case readingEditor(readingBook: ReadingBook)
    case readingList
    case readingRegister(book: Book)
}

extension ViewType {
    @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .bookRegister:
            BookRegisterView()
        case .bookSelector:
            BookSelectorView()
        case .readingEditor(readingBook: let readingBook):
            ReadingEditorView(readingBook: readingBook)
        case .readingList:
            ReadingListView()
        case .readingRegister(let book):
            ReadingRegisterView(book: book)
        }
    }
}
