//
//  RegisterViewModel.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/02.
//

import Foundation
import UIKit

@MainActor
@Observable
final class BookRegisterViewModel {
    var title: String = ""
    var author: String = ""
    var page: String = ""
    var imageURL: URL? = nil
    
    var isRegistered: Bool = false
    var alert: (isActive: Bool, title: String, message: String) = (false, "", "")
    
    let bookRepository: BookRepository
    let filer: Filer
    
    init(bookRepository: BookRepository, filer: Filer) {
        self.bookRepository = bookRepository
        self.filer = filer
    }
    
    func register() -> Book? {
        if !Book.isValidRequiredInput(title: title, page: page) {
            alert = (true, "必須項目を入力してください", "タイトルとページ数は入力必須です")
            return nil
        }
        if !Book.isValidPageInput(page) {
            alert = (true, "ページ数が正しくありません", "ページ数は正数で入力してください")
            return nil
        }
        let book = Book(
            title: title,
            page: Int(page)!,
            author: author,
            imageUrl: imageURL
        )
        
        do {
            try bookRepository.registerOrUpdate(book: book)
        } catch {
            alert = (true, "登録に失敗しました", error.localizedDescription)
            return nil
        }
        isRegistered = true
        return book
    }
    
    func addCapturedImage(_ image: UIImage) {
        guard let data = image.pngData() else {
            alert = (true, "画像の取得に失敗しました", "再度お試しください")
            return
        }
        do {
            imageURL = try filer.saveImage(imageData: data)
        } catch {
            alert = (true, "画像の保存に失敗しました", "再度お試しください")
        }
    }
    
    func cleanImageIfUnregistered() {
        guard !isRegistered, let imageURL else {
            return
        }
        try? filer.removeImage(imageURL: imageURL)
    }
    
    func fetchBookFromISBN(isbnCode: String) async {
        do {
            let result = try await bookRepository.fetch(isbnCode: isbnCode)
            title = result.title
            author = result.author ?? ""
            page = String(result.page)
            imageURL = result.imageUrl
        } catch {
            alert = (true, "本の情報が取得できませんでした", error.localizedDescription)
        }
    }
}
