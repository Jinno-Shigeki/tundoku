//
//  FilerImpl.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/03.
//

import Foundation

struct FilerImpl: Filer {
    func saveImage(imageData: Data) throws -> URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".png"
        let fileURL = dir.appendingPathComponent(fileName)
        try imageData.write(to: fileURL)
        return fileURL
    }
    
    func removeImage(imageURL: URL) throws {
        try FileManager.default.removeItem(at: imageURL)
    }
}
