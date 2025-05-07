//
//  BookData.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/03.
//

import Foundation
import SwiftData

@Model
final class ReadingData {
    @Attribute(.unique) var id: String
    var readingPage: Int
    var bookId: String
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: String = UUID().uuidString,
        bookId: String,
        readingPage: Int = 0,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.readingPage = readingPage
        self.bookId = bookId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func updateReadingPage(_ newReadingPage: Int) {
        self.readingPage = newReadingPage
    }
}
