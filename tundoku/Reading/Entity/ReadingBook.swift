//
//  ReadingBook.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

struct ReadingBook: Hashable {
    let book: Book
    let readingPage: Int
    
    init(book: Book, readingPage: Int) {
        self.book = book
        self.readingPage = readingPage
    }
}
