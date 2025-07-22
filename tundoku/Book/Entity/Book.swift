//
//  BookInfo.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import Foundation

struct Book: Hashable {
    let id: String
    let title: String
    let page: Int
    let author: String?
    let imageUrl: URL?
    
    init(
        id: String = UUID().uuidString,
        title: String,
        page: Int,
        author: String? = nil,
        imageUrl: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.author = author
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
