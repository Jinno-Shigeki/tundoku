//
//  BookEditor.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/04.
//

import SwiftUI

struct BookEditor: View {
    @Binding var title: String
    @Binding var author: String
    @Binding var page: String
    
    @State private var isCameraSheet: Bool = false
    
    let imageURL: URL?
    let onCapturedImage: (UIImage) -> Void
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 24) {
            textFieldSection(
                title: "タイトル",
                placeHolder: "タイトル",
                text: $title,
                isRequired: true
            )
            
            textFieldSection(
                title: "著者",
                placeHolder: "著者",
                text: $author
            )
            
            textFieldSection(
                title: "ページ数",
                placeHolder: "ページ数",
                text: $page,
                isRequired: true
            )
            .keyboardType(.numberPad)
            
            imageSection()
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .sheet(isPresented: $isCameraSheet) {
            CameraView() { uiImage in
                onCapturedImage(uiImage)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("完了") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    init(
        title: Binding<String>,
        author: Binding<String>,
        page: Binding<String>,
        imageURL: URL? = nil,
        onCapturedImage: @escaping (UIImage) -> Void
    ) {
        self._title = title
        self._author = author
        self._page = page
        self.imageURL = imageURL
        self.onCapturedImage = onCapturedImage
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
                    Text("※必須")
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
            
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .frame(width: 90, height: 90)
            } placeholder: {
                Button {
                    isCameraSheet = true
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
    @Previewable @State var title: String = ""
    @Previewable @State var author: String = ""
    @Previewable @State var page: String = ""
    
    NavigationStack {
        BookEditor(
            title: $title,
            author: $author,
            page: $page,
            imageURL: nil
        ) { _ in
            
        }
    }
}
