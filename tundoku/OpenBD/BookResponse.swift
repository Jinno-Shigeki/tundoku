//
//  BookResponse.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

struct BookResponse: Decodable {
    let summary: Summary
    
    struct Summary: Decodable {
        let isbn: String?
        let title: String?
        let author: String?
        let publisher: String?
        let pubdate: String?
        let cover: String?
        
        func convertDate() -> Date? {
            guard let pubdate = pubdate else { return nil }
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ja_JP")
            formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
            switch pubdate.count {
            case 6:
                formatter.dateFormat = "yyyyMM"
            case 8:
                formatter.dateFormat = "yyyyMMdd"
            default:
                return nil
            }
            return formatter.date(from: pubdate)
        }
        
        func convertURL() -> URL? {
            guard let cover else { return nil }
            return URL(string: cover)
        }
    }
}

