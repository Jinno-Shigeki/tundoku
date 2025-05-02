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
final class RegisterViewModel {
    var title: String = ""
    var author: String = ""
    var page: String = ""
    var isbn: String = ""
    var publishDate: Date = Date()
    var imageURL: URL? = nil
    
    var isRegistered: Bool = false
    var alert: (isActive: Bool, title: String, message: String) = (false, "", "")
    
    let filer: Filer
    
    init(filer: Filer) {
        self.filer = filer
    }
    
    func register() {
        if title.isEmpty || page.isEmpty {
            alert = (
                true,
                "必須項目を入力してください",
                "タイトルとページ数は入力必須です"
            )
            return
        }
        isRegistered = true
    }
    
    func addCapturedImage(_ image: UIImage) {
        guard let data = image.pngData() else {
            alert = (
                true,
                "画像の取得に失敗しました",
                "再度お試しください"
            )
            return
        }
        do {
            imageURL = try filer.saveImage(imageData: data)
        } catch {
            alert = (
                true,
                "画像の保存に失敗しました",
                "再度お試しください"
            )
        }
    }
    
    func cleanImageIfUnregistered() {
        guard !isRegistered, let imageURL else {
            return
        }
        try? filer.removeImage(imageURL: imageURL)
    }
}
