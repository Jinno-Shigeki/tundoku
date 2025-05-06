//
//  BookListViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

@MainActor
@Observable
final class BookListViewModel {
    var books: [Book] = []
    
    var alert: (isShow: Bool, title: String, message: String) = (false, "", "")
    
    let bookRepository: BookRepository
    
    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
    
    func fetchBooks() {
        do {
            books = try bookRepository.fetchAll()
        } catch {
            alert = (true, "本の取得に失敗しました", error.localizedDescription)
        }
    }
}
