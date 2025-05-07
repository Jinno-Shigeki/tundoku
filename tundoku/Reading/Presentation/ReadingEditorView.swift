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
                    .font(.headline)
                Text("\(viewModel.readingBook.book.page)ページ中、\(viewModel.readingBook.reading.readingPage)ページ")
                    .font(.caption2.weight(.thin))
                
                VStack(spacing: 0) {
                    HStack(alignment: .bottom) {
                        Text("進捗を更新")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(String(format: "%0.0f", viewModel.updateProgressValue))
                            .font(.caption2)
                    }
                    
                    Slider(value: $viewModel.updateProgressValue, in: 0...CGFloat(viewModel.readingBook.book.page), step: 1)
                }
                .padding(.top, 16)
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("本の情報")
                        .font(.headline)
                    
                    HStack(alignment: .top) {
                        AsyncImage(url: viewModel.readingBook.book.imageUrl) { image in
                            image
                                .scaledToFit()
                                .frame(width: 75, height: 90)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            Image(systemName: "book.closed")
                                .scaledToFit()
                                .frame(width: 75, height: 90)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.readingBook.book.title)
                                .font(.caption.bold())
                            
                            Text(viewModel.readingBook.book.author ?? "不明")
                                .fontWeight(.thin)
                                .font(.caption2)
                            
                            Text("\(viewModel.readingBook.book.page) ページ")
                                .fontWeight(.thin)
                                .font(.caption2)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("出版社")
                            .font(.caption.bold())
                        Text(viewModel.readingBook.book.publisher ?? "不明")
                            .font(.caption2)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ISBNコード")
                            .font(.caption.bold())
                        Text(viewModel.readingBook.book.isbn ?? "不明")
                            .font(.caption)
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
