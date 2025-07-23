//
//  ReminderListView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/06/03.
//

import SwiftUI

struct ReminderListView: View {
    @StateObject private var viewModel = ReminderViewModel()
    @State private var newTime = Date()
    @State private var isPresentingAddReminder = false
    @State private var isAlertPresented: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.reminders) { reminder in
                        HStack {
                            Text(reminder.time.formatted(date: .omitted, time: .shortened))
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    .onDelete(perform: viewModel.removeReminder)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("読書アラーム")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task.detached {
                            let result = try? await UNUserNotificationCenter.current()
                                .requestAuthorization(options: [.alert, .badge, .sound])
                            await MainActor.run {
                                if result ?? false {
                                    isPresentingAddReminder = true
                                } else {
                                    isAlertPresented = true
                                }
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddReminder) {
                AddReminderView()
            }
            .alert(Text("通知を許可してください"), isPresented: $isAlertPresented, actions: {
                Button("設定を開く") {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("キャンセル", role: .cancel) { }
            }, message: {
                Text("リマインダーを追加するには通知設定を許可する必要があります。")
            })
        }
    }
}

#Preview {
    ReminderListView()
}
