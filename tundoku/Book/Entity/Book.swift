//
//  BookInfo.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import Foundation

struct Book {
    var isbn: String?
    var title: String
    var author: String?
    var publisher: String?
    var publishDate: Date?
    var page: Int?
    var imageUrl: URL?
    
    init(
        isbn: String? = nil,
        title: String,
        author: String? = nil,
        publisher: String? = nil,
        publishDate: Date? = nil,
        page: Int? = nil,
        imageUrl: URL? = nil
    ) {
        self.isbn = isbn
        self.title = title
        self.author = author
        self.publisher = publisher
        self.publishDate = publishDate
        self.page = page
        self.imageUrl = imageUrl
    }
}
