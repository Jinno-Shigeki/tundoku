//
//  BookRepository.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

protocol BookRepository: Sendable {
    func fetch(isbnCode: String) async throws -> Book

    @MainActor
    func fetchAll() throws -> [Book]
    @MainActor
    func registerOrUpdate(book: Book) throws
}
