//
//  RegisterView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/02.
//

import SwiftUI

struct BookRegisterView: View {
    private enum SheetType: String, Identifiable {
        case camera
        case barcode
        var id: String { rawValue }
    }

    @State private var viewModel = BookRegisterViewModel(
        bookRepository: BookRepositoryImpl(openBDRepository: OpenBDRepositoryImpl()),
        filer: FilerImpl()
    )
    @State private var sheetType: SheetType? = nil
    @FocusState private var focusState: BookEditor.FieldType?
    
    var body: some View {
        ScrollView {
            BookEditor(
                title: $viewModel.title,
                author: $viewModel.author,
                page: $viewModel.page,
                focusState: $focusState,
                imageURL: viewModel.imageURL,
                onCapturedImage: { viewModel.addCapturedImage($0) }
            )
        }
        .sheet(item: $sheetType) { sheetType in
            switch sheetType {
            case .camera:
                CameraView() { uiImage in
                    viewModel.addCapturedImage(uiImage)
                }
                .edgesIgnoringSafeArea(.all)
            case .barcode:
                BookCodeReaderView { code in
                    Task {
                        await viewModel.fetchBookFromISBN(isbnCode: code)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    sheetType = .barcode
                } label: {
                    Image(systemName: "barcode.viewfinder")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    guard let book = viewModel.register() else {
                        return
                    }
                    Router.shared.push(.readingRegister(book: book))
                } label: {
                    Text("追加")
                }
            }
        }
        .alert(viewModel.alert.title, isPresented: $viewModel.alert.isActive) {
        } message: {
            Text(viewModel.alert.message)
        }
        .onDisappear {
            viewModel.cleanImageIfUnregistered()
        }
        .onTapGesture {
            focusState = nil
        }
        .navigationTitle("本を追加")
    }
}

#Preview {
    NavigationStack {
        BookRegisterView()
    }
}
