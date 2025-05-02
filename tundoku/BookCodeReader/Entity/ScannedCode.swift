//
//  ScannedCode.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

struct ScannedCode {
    var code: String
    var isValid: Bool {
        ScannedCode.validate(code: code)
    }
    
    init(_ code: String) {
        self.code = code
    }
    
    private static func validate(code: String) -> Bool {
        // ISBN-13コードのみOKとする
        // 1. 13桁かどうか
        guard code.count == 13 else { return false }
        // 2. すべての文字が数字かどうか（Intに変換できるか）
        guard code.allSatisfy({ $0.isNumber }) else { return false }
        // 3. 先頭が978または979
        return code.hasPrefix("978") || code.hasPrefix("979")
    }
}
