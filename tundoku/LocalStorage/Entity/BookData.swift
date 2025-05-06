//
//  BookData.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/03.
//

import Foundation
import SwiftData

@Model
final class BookData {
    @Attribute(.unique) var id: String
    var title: String
    var page: Int
    var author: String?
    var publisher: String?
    var publishDate: Date?
    var isbn: String?
    var imageUrl: URL?
    
    init(
        id: String = UUID().uuidString,
        title: String,
        page: Int,
        author: String? = nil,
        publisher: String? = nil,
        publishDate: Date? = nil,
        isbn: String? = nil,
        imageUrl: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.page = page
        self.author = author
        self.publisher = publisher
        self.publishDate = publishDate
        self.isbn = isbn
        self.imageUrl = imageUrl
    }
}
