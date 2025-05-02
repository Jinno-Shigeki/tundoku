//
//  BookView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import SwiftUI

struct BookView: View {
    @State private var viewModel: BookViewModel
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .task {
            do {
                try await viewModel.onFetch()
            } catch {
                print(error)
            }
        }
    }
    
    init(
        isbnCode: String
    ) {
        self._viewModel = State(
            initialValue: BookViewModel(
                isbnCode: isbnCode,
                bookRepository: BookRepositoryImpl(
                    openBDRepository: OpenBDRepositoryImpl()
                )
            )
        )
    }
}

#Preview {
    BookView(isbnCode: "9784798172958")
}
