//
//  ReadingRepository.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/05.
//

import Foundation
import SwiftData

struct ReadingRepositoryImpl {
    @MainActor
    func register(bookId: String, readingPage: Int) throws {
        let context = ModelContainer.appContainer.mainContext
        context.insert(ReadingData(bookId: bookId, readingPage: readingPage))
        try context.save()
    }
}
