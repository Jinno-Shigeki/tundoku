//
//  BookListCell.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/06.
//

import SwiftUI

struct BookListCell: View {
    let book: Book
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: book.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 115, height: 150)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                Image(systemName: "book.closed")
                    .scaledToFill()
                    .frame(width: 115, height: 150)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.caption.bold())
                    .lineLimit(2)
                
                if let author = book.author {
                    Text(author)
                        .fontWeight(.thin)
                        .font(.caption2)
                        .lineLimit(1)
                }
                
                Text("\(book.page) ページ")
                    .fontWeight(.thin)
                    .font(.caption2)
                    .lineLimit(1)
            }
            
            Spacer()
        }
    }
}

#Preview {
    VStack {
        BookListCell(
            book: Book(
                title: "長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル長いタイトル",
                page: 300,
                author: "長い名前長い名前長い名前長い名前長い名前長い名前",
                publisher: "長い出版社名称長い出版社名称長い出版社名称長い出版社名称長い出版社名称",
                publishDate: Date(),
                isbn: "9784063574831",
                imageUrl: URL(string: "https://img.hanmoto.com/bd/img/9784780802047.jpg")!
            )
        )
        
        BookListCell(
            book: Book(
                title: "タイトル",
                page: 300,
                author: "田中太郎"
            )
        )
        
        BookListCell(
            book: Book(
                title: "タイトル",
                page: 300
            )
        )
    }
    .padding(.horizontal, 16)
}
