//
//  ReadingListCell.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

struct ReadingListCell: View {
    let readingBook: ReadingBook
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: readingBook.book.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 48)
                }
                .frame(width: 64, height: 84)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(readingBook.book.title)
                        .font(.headline)
                        .lineLimit(2)
                    Text(readingBook.book.author ?? "")
                        .font(.caption.weight(.thin))
                        .lineLimit(1)
                }
                Spacer()
            }
            
            ReadingProgress(totalPage: readingBook.book.page, readingPage: readingBook.readingPage)
        }
        .padding([.horizontal, .vertical], 16)
    }
}

#Preview {
    VStack {
        ReadingListCell(
            readingBook: ReadingBook(
                book: Book (
                    title: "AWS運用入門",
                    page: 479,
                    author: "佐竹陽一, 山崎翔平, 小倉大",
                    publisher: "SBクリエイティブ株式会社",
                    publishDate: Date(),
                    isbn: "9784815615499",
                    imageUrl: nil
                ),
                readingPage: 10
            )
        )
        .background(.brown.opacity(0.1))
        
        ReadingListCell(
            readingBook: ReadingBook(
                book: Book (
                    title: "AWS運用入門",
                    page: 0,
                    author: nil,
                    publisher: nil,
                    publishDate: nil,
                    isbn: nil,
                    imageUrl: nil
                ),
                readingPage: 0
            )
        )
        .background(.brown.opacity(0.1))
    }
}
