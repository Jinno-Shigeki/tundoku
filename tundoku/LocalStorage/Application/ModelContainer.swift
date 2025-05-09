//
//  ModelContainer.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/03.
//

import Foundation
import SwiftData

extension ModelContainer {
    private static let configuration = ModelConfiguration(for: ReadingData.self, BookData.self)
    static let appContainer = try! ModelContainer(for: ReadingData.self, BookData.self, configurations: configuration)
}
