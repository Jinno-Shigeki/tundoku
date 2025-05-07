//
//  ReadingRegisterViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/04.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable
final class ReadingRegisterViewModel {
    var readingPage: Int = 0
    
    var alert: (isActive: Bool, title: String, message: String) = (false, "", "")
    
    let readingRepository: ReadingRepository

    
    init(readingRepository: ReadingRepository) {
        self.readingRepository = readingRepository
    }
    
    func register(bookid: String) -> Bool {
        do {
            try readingRepository.register(bookId: bookid, readingPage: readingPage)
            return true
        } catch {
            alert = (true, "追加できませんでした、もう一度お試しください。", error.localizedDescription)
            return false
        }
    }
}
