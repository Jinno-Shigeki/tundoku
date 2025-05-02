//
//  BookRepositoryImpl.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

struct BookRepositoryImpl: BookRepository {
    let openBDRepository: OpenBDRepository
    
    init(openBDRepository: OpenBDRepository) {
        self.openBDRepository = openBDRepository
    }
    
    func fetchBook(isbnCode: String) async throws -> Book {
        let result = try await openBDRepository.fetchBook(isbnCode: isbnCode)
        return Book(
            isbn: result.summary.isbn,
            title: result.summary.title ?? "",
            author: result.summary.author,
            publisher: result.summary.publisher,
            publishDate: result.summary.convertDate(),
            page: nil,
            imageUrl: result.summary.convertURL()
        )
    }
}
