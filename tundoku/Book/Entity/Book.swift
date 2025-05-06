//
//  BookInfo.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import Foundation

struct Book {
    let id: String
    let title: String
    let page: Int
    let author: String?
    let publisher: String?
    let publishDate: Date?
    let isbn: String?
    let imageUrl: URL?
    
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
        self.isbn = isbn
        self.title = title
        self.author = author
        self.publisher = publisher
        self.publishDate = publishDate
        self.page = page
        self.imageUrl = imageUrl
    }
    
    static func isValidRequiredInput(title: String, page: String) -> Bool {
        !title.isEmpty && !page.isEmpty
    }
    
    static func isValidPageInput(_ page: String) -> Bool {
        (Int(page) ?? 0) > 0
    }
}
