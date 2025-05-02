//
//  BookViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

@Observable
class BookViewModel {
    var book: Book?
    
    private let isbnCode: String
    private let bookRepository: BookRepository
    
    init(isbnCode: String, bookRepository: BookRepository) {
        self.isbnCode = isbnCode
        self.bookRepository = bookRepository
    }
    
    func onFetch() async throws {
        let result = try await bookRepository.fetchBook(isbnCode: isbnCode)
        book = result
    }
}
