//
//  ReadingListView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

struct ReadingListView: View {
    @State private var viewModel = ReadingListViewModel(
        readingRepository: ReadingRepositoryImpl(),
        bookRepository: BookRepositoryImpl(openBDRepository: OpenBDRepositoryImpl())
    )
    @State private var actionSheetIsPresented: Bool = false
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.readingBooks, id: \.self) { readingBook in
                Button {
                    Router.shared.push(.readingEditor(readingBook: readingBook))
                } label: {
                    ReadingListCell(readingBook: readingBook)
                }
                .tint(.primary)
            }
        }
        .onAppear {
            viewModel.fetchReadings()
        }
        .toolbar {
            ToolbarItem {
                Button {
                    actionSheetIsPresented = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .confirmationDialog("進捗を追加", isPresented: $actionSheetIsPresented, titleVisibility: .visible, actions: {
            Button {
                Router.shared.push(.bookSelector)
            } label: {
                Text("追加")
            }
        
            Button {
                Router.shared.push(.bookRegister)
            } label: {
                Text("本を登録して追加")
            }
        })
        .navigationTitle("一覧")
    }
}

#Preview {
    PreviewSupport.createPreviewContainer()
    return NavigationStack {
        ReadingListView()
    }
}
