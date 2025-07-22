//
//  ReminderListViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/06/03.
//

import Foundation
import UserNotifications

struct ReadingReminder: Identifiable, Codable {
    let id: UUID
    var time: Date
}

final class ReminderViewModel: ObservableObject {
    @Published var reminders: [ReadingReminder] = []

    init() {
        load()
    }

    func addReminder(time: Date) {
        let reminder = ReadingReminder(id: UUID(), time: time)
        reminders.append(reminder)
        scheduleNotification(for: reminder)
        save()
    }

    func removeReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
        save()
    }

    private func scheduleNotification(for reminder: ReadingReminder) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "読書の時間です"
        content.body = "登録した時間になりました！"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: reminder.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        let request = UNNotificationRequest(
            identifier: reminder.id.uuidString,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

    private func save() {
        // 保存処理（UserDefaults or ファイルなど）
    }

    private func load() {
        // 読み込み処理
    }
}
