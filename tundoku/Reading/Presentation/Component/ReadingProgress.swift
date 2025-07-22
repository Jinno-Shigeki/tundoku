//
//  ReadingProgressView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

struct ReadingProgress: View {
    private let totalPage: Int
    private let readingPage: Int
    private let percentage: Int
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(percentage)%")
                .font(.body)
            
            ProgressView(value: progress)
                .progressViewStyle(.linear)
                .scaleEffect(x: 1, y: 2)
                .clipShape(Capsule())
        }
        .onAppear {
            withAnimation(.linear) {
               progress = CGFloat(readingPage) / CGFloat(totalPage)
            }
        }
    }
    
    init(
        totalPage: Int,
        readingPage: Int
    ) {
        self.totalPage = totalPage
        self.readingPage = readingPage
        self.percentage = totalPage == 0 ? 0 : Int(Float(readingPage)/Float(totalPage)*100)
        
    }
}

#Preview {
    VStack(spacing: 20) {
        ReadingProgress(totalPage: 300, readingPage: 60)
        ReadingProgress(totalPage: 300, readingPage: 120)
        ReadingProgress(totalPage: 300, readingPage: 180)
        ReadingProgress(totalPage: 300, readingPage: 240)
        ReadingProgress(totalPage: 300, readingPage: 300)
        ReadingProgress(totalPage: 0, readingPage: 0)
    }
    .padding(.horizontal, 16)
}
