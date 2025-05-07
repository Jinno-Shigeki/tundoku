//
//  ReadingBook.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

struct ReadingBook: Hashable {
    let book: Book
    let reading: Reading
    
    init(book: Book, reading: Reading) {
        self.book = book
        self.reading = reading
    }
    
    func updateReading(_ reading: Reading) -> ReadingBook {
        ReadingBook(book: book, reading: reading)
    }
}
