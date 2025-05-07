//
//  ReadingRegisterView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/04.
//

import SwiftUI

struct ReadingRegisterView: View {
    @State var viewModel = ReadingRegisterViewModel(
        readingRepository: ReadingRepositoryImpl()
    )
    
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("現在のページ")
                        .font(.subheadline.bold())
                    
                    TextField("0", value: $viewModel.readingPage, format: .number)
                        .font(.body)
                        .padding([.vertical, .horizontal], 12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0.5)
                        }
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .bottom) {
                        Text("進捗")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let percentage: Double = Double(viewModel.readingPage) / Double(book.page) * 100
                        Text("\(String(format: "%.0f", percentage))%")
                            .fontWeight(.thin)
                            .font(.footnote.bold())
                    }
                    
                    ProgressView(value: Double(viewModel.readingPage) / Double(book.page))
                        .progressViewStyle(.linear)
                        .scaleEffect(x: 1, y: 1.4)
                    
                    Text("残りページ数: \(book.page - viewModel.readingPage)")
                        .fontWeight(.thin)
                        .font(.footnote.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("本の情報")
                        .font(.headline)
                    
                    HStack(alignment: .top) {
                        AsyncImage(url: book.imageUrl) { image in
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
                            Text(book.title)
                                .font(.caption.bold())
                            
                            Text(book.author ?? "不明")
                                .fontWeight(.thin)
                                .font(.caption2)
                            
                            Text("\(book.page) ページ")
                                .fontWeight(.thin)
                                .font(.caption2)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("出版社")
                            .font(.caption.bold())
                        Text(book.publisher ?? "不明")
                            .font(.caption2)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ISBNコード")
                            .font(.caption.bold())
                        Text(book.isbn ?? "不明")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if viewModel.register(bookid: book.id) {
                        Router.shared.popRoot()
                    }
                } label: {
                    Text("追加")
                }
            }
        }
        .navigationTitle("進捗を追加")
    }
}

#Preview {
    NavigationStack {
        ReadingRegisterView(book: Book(title: "ドメイン駆動設計", page: 100, author: "太郎くん", publisher: "田中出版", isbn: "9784813014117"))
    }
}
