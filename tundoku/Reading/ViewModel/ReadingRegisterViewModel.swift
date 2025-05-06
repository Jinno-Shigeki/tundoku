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
    
    @ObservationIgnored
    var isRegistered: Bool = false

    
    init() {
    }
    
    func register() {
        isRegistered = true
    }
}
