//
//  ReadingListViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

@MainActor
@Observable
final class ReadingListViewModel {
    var readingBooks: [ReadingBook] = []
    
    var alert: (isActive: Bool, title: String, message: String) = (false, "", "")
    
    let readingRepository: ReadingRepository
    let bookRepository: BookRepository
    
    init(readingRepository: ReadingRepository, bookRepository: BookRepository) {
        self.readingRepository = readingRepository
        self.bookRepository = bookRepository
    }
    
    func fetchReadings() {
        var readings: [Reading] = []
        var books: [Book] = []
        do {
            readings = try readingRepository.fetchAll()
            books = try bookRepository.fetchAll()
        } catch {
            alert = (true, "データの取得に失敗しました", error.localizedDescription)
            return
        }
        readingBooks = readings.compactMap { reading in
            guard let book = books.first(where: { $0.id == reading.bookId }) else {
                return nil
            }
            return ReadingBook(book: book, readingPage: reading.readingPage)
        }
    }
}
