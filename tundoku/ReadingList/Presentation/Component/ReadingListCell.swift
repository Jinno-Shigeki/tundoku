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
            
            if book.page != nil {
                ReadingProgressView(totalPage: book.page ?? 0, readingPage: book.page ?? 0)
            }
        }
        .padding([.horizontal, .vertical], 16)
    }
}

#Preview {
    VStack {
        ReadingListCell(
            book: Book(
                isbn: "9784815615499",
                title: "AWS運用入門",
                author: "佐竹陽一, 山崎翔平, 小倉大",
                publisher: "SBクリエイティブ株式会社",
                publishDate: Date(),
                page: 479,
                imageUrl: nil
            )
        )
        .background(.brown.opacity(0.1))
        
        ReadingListCell(
            book: Book(
                isbn: nil,
                title: "AWS運用入門",
                author: nil,
                publisher: nil,
                publishDate: nil,
                page: nil,
                imageUrl: nil
            )
        )
        .background(.brown.opacity(0.1))
    }
}
