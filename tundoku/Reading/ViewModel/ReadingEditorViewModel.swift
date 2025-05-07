//
//  ReadingEditorViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/07.
//

import Foundation

@MainActor
@Observable
final class ReadingEditorViewModel {
    var readingBook: ReadingBook
    var updateProgressValue: CGFloat = 0
    
    var alert: (isActive: Bool, title: String, message: String) = (false, "", "")
    
    let readingRepository: ReadingRepository
    
    init(readingBook: ReadingBook, readingRepository: ReadingRepository) {
        self.readingBook = readingBook
        self.readingRepository = readingRepository
    }
    
    func updateReadingPage() {
        do {
            let result = try readingRepository.updateReadingPage(id: readingBook.reading.id, readingPage: Int(updateProgressValue))
            readingBook = readingBook.updateReading(result)
        } catch {
            alert = (true, "進捗の更新に失敗しました", error.localizedDescription)
        }
    }
}
