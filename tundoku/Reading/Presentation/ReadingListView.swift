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
    
    private var router: Router = .shared
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.readingBooks, id: \.self) { readingBook in
                ReadingListCell(readingBook: readingBook)
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
        .confirmationDialog("進捗を追加する", isPresented: $actionSheetIsPresented, titleVisibility: .visible, actions: {
            Button {
                
            } label: {
                Text("進捗を追加")
            }
        
            Button {
                router.push(.bookRegister)
            } label: {
                Text("本を登録して進捗を追加")
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
