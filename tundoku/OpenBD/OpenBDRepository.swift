//
//  OpenBDRepository.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

protocol OpenBDRepository: Sendable {
    func fetchBook(isbnCode: String) async throws -> BookResponse
}
