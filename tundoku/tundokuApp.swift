//
//  tundokuApp.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import SwiftUI
import SwiftData

@main
struct tundokuApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .task {
                    let _ = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                }
        }
    }
}
