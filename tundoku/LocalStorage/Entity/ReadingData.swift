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
    
    init(
        bookId: String,
        readingPage: Int = 0
    ) {
        self.id = UUID().uuidString
        self.readingPage = readingPage
        self.bookId = bookId
    }
}
