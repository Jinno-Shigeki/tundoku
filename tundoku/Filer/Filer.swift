//
//  Filer.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/03.
//

import Foundation

protocol Filer {
    func saveImage(imageData: Data) throws -> URL
    func removeImage(imageURL: URL) throws
}
