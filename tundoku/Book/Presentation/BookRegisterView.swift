//
//  RegisterView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/02.
//

import SwiftUI

struct BookRegisterView: View {
    private enum SheetType {
        case camera
        case barcode
    }

    @State private var viewModel = BookRegisterViewModel(
        bookRepository: BookRepositoryImpl(openBDRepository: OpenBDRepositoryImpl()),
        filer: FilerImpl()
    )
    @State private var sheetState: (Bool, SheetType) = (false, .camera)
    
    var body: some View {
        ScrollView {
            BookEditor(
                title: $viewModel.title,
                author: $viewModel.author,
                page: $viewModel.page,
                isbn: $viewModel.isbn,
                publishDate: $viewModel.publishDate,
                imageURL: viewModel.imageURL,
                onCapturedImage: { viewModel.addCapturedImage($0) }
            )
        }
        .sheet(isPresented: $sheetState.0) {
            switch sheetState.1 {
            case .camera:
                CameraView() { uiImage in
                    viewModel.addCapturedImage(uiImage)
                }
                .edgesIgnoringSafeArea(.all)
            case .barcode:
                BookCodeReaderView { code in
                    
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "barcode.viewfinder")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.register()
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
        .navigationTitle("本を追加")
    }
}

#Preview {
    NavigationStack {
        BookRegisterView()
    }
}
