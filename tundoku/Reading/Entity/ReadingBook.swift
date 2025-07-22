//
//  ReadingBook.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

struct ReadingBook: Hashable {
    let reading: Reading
    let title: String
    let page: Int
    let author: String?
    let imageUrl: URL?
    
    init(
        reading: Reading,
        title: String,
        page: Int,
        author: String?,
        imageUrl: URL?
    ) {
        self.reading = reading
        self.title = title
        self.page = page
        self.author = author
        self.imageUrl = imageUrl
    }
    
    func updateReading(_ reading: Reading) -> ReadingBook {
        ReadingBook(
            reading: reading,
            title: title,
            page: page,
            author: author,
            imageUrl: imageUrl
        )
    }
}
