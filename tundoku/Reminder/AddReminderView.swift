//
//  AddReminderView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/06/03.
//

import SwiftUI

struct AddReminderView: View {
    enum TextFieldType: Hashable {
        case title
    }
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusState: TextFieldType?
    @State private var alarmDate = Date()
    @State private var alarmName = ""
    @State private var isSoundEnabled = true
    @State private var isRepeating = false
    @State private var selectedDays: Set<String> = []
    let startAt = Date()
    let endAt = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    let weekDayFrame: CGFloat = (UIScreen.main.bounds.width - 64) / 7
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                DatePicker("時間を選択", selection: $alarmDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                
                List {
                    Section {
                        TextField("アラーム名（任意）", text: $alarmName)
                            .focused($focusState, equals: .title)
                        Toggle("サウンド", isOn: $isSoundEnabled)
                        Toggle("繰り返し", isOn: $isRepeating)
                    }
                    .listRowBackground(Color(UIColor.systemGray6))
                    
                    if isRepeating {
                        weekSelectComponent
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.insetGrouped)
                .listSectionSpacing(4)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("アラームを追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        dismiss()
                    }
                }
            }
            .onTapGesture {
                focusState = nil
            }
        }
    }
    
    var weekSelectComponent: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { day in
                    let isSelected = selectedDays.contains(day)
                    Button {
                        if isSelected {
                            selectedDays.remove(day)
                        } else {
                            selectedDays.insert(day)
                        }
                    } label: {
                        Text(day)
                            .font(.body)
                            .dynamicTypeSize(.medium)
                            .frame(width: weekDayFrame, height: weekDayFrame)
                            .background(isSelected ? Color.black : Color.gray.opacity(0.2))
                            .foregroundColor(isSelected ? .white : .primary)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .dynamicTypeSize(.medium)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    AddReminderView()
}
