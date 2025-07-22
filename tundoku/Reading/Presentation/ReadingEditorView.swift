//
//  ReadingEditorView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/07.
//

import SwiftUI

struct ReadingEditorView: View {
    @State private var viewModel: ReadingEditorViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("現在の進捗")
                    .font(.title2.bold())
                Text("\(viewModel.readingBook.book.page)ページ中、\(viewModel.readingBook.reading.readingPage)ページ")
                    .font(.body.weight(.thin))
                
                VStack(spacing: 0) {
                    HStack(alignment: .bottom) {
                        Text("進捗を更新")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(String(format: "%0.0f", viewModel.updateProgressValue))
                            .font(.body)
                    }
                    
                    Slider(value: $viewModel.updateProgressValue, in: 0...CGFloat(viewModel.readingBook.book.page), step: 1)
                }
                .padding(.top, 16)
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("本の情報")
                        .font(.title2.bold())
                    
                    HStack(alignment: .top) {
                        AsyncImage(url: viewModel.readingBook.book.imageUrl) { image in
                            image
                                .scaledToFit()
                                .frame(width: 115, height: 120)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            Image(systemName: "book.closed")
                                .scaledToFit()
                                .frame(width: 115, height: 150)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.readingBook.book.title)
                                .font(.title3.bold())
                            
                            Text(viewModel.readingBook.book.author ?? "不明")
                                .fontWeight(.thin)
                                .font(.body)
                            
                            Text("\(viewModel.readingBook.book.page) ページ")
                                .fontWeight(.thin)
                                .font(.body)
                        }
                    }
                }
                .padding(.top, 16)
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
        }
        .onAppear {
            withAnimation {
                viewModel.updateProgressValue = CGFloat(viewModel.readingBook.reading.readingPage)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("保存") {
                    viewModel.updateReadingPage()
                }
            }
        }
        .navigationTitle("進捗")
    }
    
    init(readingBook: ReadingBook) {
        self._viewModel = State(initialValue: ReadingEditorViewModel(
            readingBook: readingBook,
            readingRepository: ReadingRepositoryImpl()
        ))
        UISlider.appearance().setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
    }
}

#Preview {
    let bookId = UUID().uuidString
    
    NavigationStack {
        ReadingEditorView(
            readingBook: ReadingBook(
                book: Book(id: bookId, title: "TEST", page: 200),
                reading: Reading(id: UUID().uuidString, readingPage: 100, bookId: bookId)
            )
        )
    }
}
