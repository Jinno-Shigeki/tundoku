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
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: readingBook.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 50)
                }
                .frame(width: 75, height: 90)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(readingBook.title)
                        .font(.title2.bold())
                        .lineLimit(2)
                    Text(readingBook.author ?? "")
                        .font(.body.weight(.thin))
                        .lineLimit(1)
                }
                Spacer()
            }
            
            ReadingProgress(totalPage: readingBook.page, readingPage: readingBook.reading.readingPage)
        }
        .padding([.horizontal, .vertical], 16)
    }
}

#Preview {
    let bookId1 = UUID().uuidString
    let bookId2 = UUID().uuidString
    
    VStack {
        ReadingListCell(
            readingBook: ReadingBook(
                reading: Reading(
                    id: UUID().uuidString,
                    readingPage: 100,
                    bookId: bookId1
                ),
                title: "AWS運用入門",
                page: 479,
                author: "佐竹陽一, 山崎翔平, 小倉大",
                imageUrl: nil
            )
        )
        
        ReadingListCell(
            readingBook: ReadingBook(
                reading: Reading(
                    id: UUID().uuidString,
                    readingPage: 0,
                    bookId: bookId2
                ),
                title: "AWS運用入門",
                page: 0,
                author: nil,
                imageUrl: nil
            )
        )
    }
    .background(.brown.opacity(0.1))
}
