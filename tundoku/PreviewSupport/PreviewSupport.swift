//
//  PreviewSupport.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation
import SwiftData

struct PreviewSupport {
    @MainActor
    static func createPreviewContainer() {
        let context = ModelContainer.appContainer.mainContext
        try? context.delete(model: BookData.self)
        
        let books: [BookData] = [
            BookData(title: "長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル", page: 300, author: "長い名前長い名前長い名前長い名前長い名前長い名前", imageUrl: URL(string: "https://img.hanmoto.com/bd/img/9784780802047.jpg")!), BookData(title: "タイトル", page: 300, author: "田中太郎"), BookData( title: "タイトル", page: 300 )
        ]
        for book in books {
            context.insert(book)
        }
        
        let readings: [ReadingData] = [
            ReadingData(bookId: books[0].id, readingPage: 10),
            ReadingData(bookId: books[1].id, readingPage: 10),
            ReadingData(bookId: books[2].id, readingPage: 10)
        ]
        for reading in readings {
            context.insert(reading)
        }
        try? context.save()
    }
}
