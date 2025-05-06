//
//  BookRepositoryImpl.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation
import SwiftData

struct BookRepositoryImpl: BookRepository {
    let openBDRepository: OpenBDRepository
    
    init(openBDRepository: OpenBDRepository) {
        self.openBDRepository = openBDRepository
    }
    
    func fetch(isbnCode: String) async throws -> Book {
        let result = try await openBDRepository.fetchBook(isbnCode: isbnCode)
        return Book(
            title: result.summary.title ?? "",
            page: 0,
            author: result.summary.author,
            publisher: result.summary.publisher,
            publishDate: result.summary.convertDate(),
            isbn: result.summary.isbn,
            imageUrl: result.summary.convertURL()
        )
    }
    
    @MainActor
    func registerOrUpdate(book: Book) throws {
        let bookData = convert(book: book)
        let context = ModelContainer.appContainer.mainContext
        context.insert(bookData)
        try context.save()
    }
}

extension BookRepositoryImpl {
    private func convert(book: Book) -> BookData {
        BookData(
            id: book.id,
            title: book.title,
            page: book.page,
            author: book.author,
            publisher: book.publisher,
            publishDate: book.publishDate,
            isbn: book.isbn,
            imageUrl: book.imageUrl
        )
    }
}
