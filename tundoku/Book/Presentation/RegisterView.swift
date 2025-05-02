//
//  RegisterView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/02.
//

import SwiftUI

struct RegisterView: View {
    private enum SheetType {
        case camera
        case barcode
    }
    
    @State private var viewModel = RegisterViewModel(filer: FilerImpl())
    @State private var sheetState: (Bool, SheetType) = (false, .camera)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 24) {
                textFieldSection(
                    title: "タイトル",
                    placeHolder: "タイトル",
                    text: $viewModel.title,
                    isRequired: true
                )
                
                textFieldSection(
                    title: "著者",
                    placeHolder: "著者",
                    text: $viewModel.author
                )
                
                textFieldSection(
                    title: "ページ数",
                    placeHolder: "ページ数",
                    text: $viewModel.page,
                    isRequired: true
                )
                .keyboardType(.numberPad)
                
                DatePicker("発行日", selection: $viewModel.publishDate, displayedComponents: [.date])
                    .font(.headline)
                    .datePickerStyle(.compact)
                
                textFieldSection(
                    title: "ISBNコード",
                    placeHolder: "exp.) 9780000000000",
                    text: $viewModel.isbn
                )
                .keyboardType(.numberPad)
                
                imageSection()
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
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
                    sheetState = (true, .barcode)
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
    
    func textFieldSection(
        title: String,
        placeHolder: String,
        text: Binding<String>,
        isRequired: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 4) {
                Text(title)
                    .font(.headline)
                if isRequired {
                    Text("※")
                        .font(.caption2)
                        .foregroundStyle(.red.opacity(0.8))
                }
            }
            
            TextField(placeHolder, text: text)
                .font(.body)
                .padding([.vertical, .horizontal], 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.5)
                }
        }
    }
    
    func imageSection() -> some View {
        VStack(alignment: .leading) {
            Text("画像")
                .font(.headline)
            
            AsyncImage(url: viewModel.imageURL) { image in
                image
                    .resizable()
                    .frame(width: 90, height: 90)
            } placeholder: {
                Button {
                    sheetState = (true, .camera)
                } label: {
                    Text("画像を追加")
                        .font(.body)
                        .tint(.gray.opacity(0.5))
                        .padding([.vertical, .horizontal], 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0.5)
                        }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}
