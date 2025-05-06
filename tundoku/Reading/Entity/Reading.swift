//
//  Reading.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

struct Reading {
    let id: String
    let readingPage: Int
    let bookId: String
    
    init(id: String, readingPage: Int, bookId: String) {
        self.id = id
        self.readingPage = readingPage
        self.bookId = bookId
    }
}
