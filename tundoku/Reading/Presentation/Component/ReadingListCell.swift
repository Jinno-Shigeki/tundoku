//
//  ReadingListCell.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

struct ReadingListCell: View {
    let book: Book
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: book.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
                .frame(width: 64, height: 64)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author ?? "")
                        .font(.caption.weight(.thin))
                }
                Spacer()
            }
            
            ReadingProgress(totalPage: book.page, readingPage: book.page)
        }
        .padding([.horizontal, .vertical], 16)
    }
}

#Preview {
    VStack {
        ReadingListCell(
            book: Book(
                title: "AWS運用入門",
                page: 479,
                author: "佐竹陽一, 山崎翔平, 小倉大",
                publisher: "SBクリエイティブ株式会社",
                publishDate: Date(),
                isbn: "9784815615499",
                imageUrl: nil
            )
        )
        .background(.brown.opacity(0.1))
        
        ReadingListCell(
            book: Book(
                title: "AWS運用入門",
                page: 0,
                author: nil,
                publisher: nil,
                publishDate: nil,
                isbn: nil,
                imageUrl: nil
            )
        )
        .background(.brown.opacity(0.1))
    }
}
