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
        ModelContainer.appContainer.mainContext.insert(bookData)
        try ModelContainer.appContainer.mainContext.save()
    }
    
    @MainActor
    func fetchAll() throws -> [Book] {
        let fetchDescriptor = FetchDescriptor<BookData>(predicate: nil, sortBy: [.init(\.updatedAt)] )
        let bookDatas = try ModelContainer.appContainer.mainContext.fetch(fetchDescriptor)
        return bookDatas.map { convertData(bookData: $0) }
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
    
    private func convertData(bookData: BookData) -> Book {
        Book(
            id: bookData.id,
            title: bookData.title,
            page: bookData.page,
            author: bookData.author,
            publisher: bookData.publisher,
            publishDate: bookData.publishDate,
            isbn: bookData.isbn,
            imageUrl: bookData.imageUrl
        )
    }
}
