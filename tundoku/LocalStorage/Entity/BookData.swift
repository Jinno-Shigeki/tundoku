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
    var imageUrl: URL?
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: String = UUID().uuidString,
        title: String,
        page: Int,
        author: String? = nil,
        imageUrl: URL? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.page = page
        self.author = author
        self.imageUrl = imageUrl
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
