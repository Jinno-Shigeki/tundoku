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
                        isPresentingAddReminder = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddReminder) {
//                AddReminderView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ReminderListView()
}
