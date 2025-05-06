//
//  ReadingRepository.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import Foundation

protocol ReadingRepository {
    @MainActor
    func register(bookId: String, readingPage: Int) throws
    @MainActor
    func fetchAll() throws -> [Reading]
}
