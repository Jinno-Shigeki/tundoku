//
//  ViewType.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

enum ViewType: Hashable {
    case readingList
    case book(isbnCode: String)
    case bookRegister
}

extension ViewType {
    @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .readingList:
            ReadingListView()
        case .book(let isbnCode):
            BookView(isbnCode: isbnCode)
        case .bookRegister:
            RegisterView()
        }
    }
}
