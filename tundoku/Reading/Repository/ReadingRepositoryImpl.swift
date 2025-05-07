//
//  ReadingRepository.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/05.
//

import Foundation
import SwiftData

struct ReadingRepositoryImpl: ReadingRepository {
    @MainActor
    func register(bookId: String, readingPage: Int) throws {
        let context = ModelContainer.appContainer.mainContext
        context.insert(ReadingData(bookId: bookId, readingPage: readingPage))
        try context.save()
    }
    
    @MainActor
    func fetchAll() throws -> [Reading] {
        let context = ModelContainer.appContainer.mainContext
        let descripter = FetchDescriptor<ReadingData>(predicate: nil, sortBy: [.init(\.updatedAt)])
        let result = try context.fetch(descripter)
        return result.map { convertData(data: $0) }
    }
    
    @MainActor
    func updateReadingPage(id: String, readingPage: Int) throws -> Reading {
        let context = ModelContainer.appContainer.mainContext
        let descripter = FetchDescriptor<ReadingData>(predicate: #Predicate { $0.id == id })
        guard let data = try context.fetch(descripter).first else {
            throw NSError(domain: "jin.tundoku", code: 404)
        }
        data.updateReadingPage(readingPage)
        context.insert(data)
        try context.save()
        return convertData(data: data)
    }
}

extension ReadingRepositoryImpl {
    private func convertData(data: ReadingData) -> Reading {
        Reading(
            id: data.id,
            readingPage: data.readingPage,
            bookId: data.bookId
        )
    }
}
