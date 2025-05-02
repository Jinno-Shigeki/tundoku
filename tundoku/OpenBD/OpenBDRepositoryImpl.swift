//
//  OpenBDAPI.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

struct OpenBDRepositoryImpl: OpenBDRepository {
    let client = APIClient()
    
    func fetchBook(isbnCode: String) async throws -> BookResponse {
        let request = OpenBDRequest<[BookResponse]>(.fetchBook(isbnCode: isbnCode))
        return try await client.run(request: request).first!
    }
}

extension OpenBDRepositoryImpl {
    private enum OpenBDRequestType {
        case fetchBook(isbnCode: String)
    }
    
    private struct OpenBDRequest<T: Decodable>: Request {
        typealias Response = T
        private let type: OpenBDRequestType
        
        init (_ type: OpenBDRequestType) {
            self.type = type
        }
        
        var baseURL: URL {
            URL(string: "https://api.openbd.jp/v1/")!
        }
        
        var path: String {
            switch type {
            case .fetchBook:
                return "get"
            }
        }
        
        var method: HTTPMethod {
            switch type {
            case .fetchBook:
                return .get
            }
        }
        
        var headers: [String : String]? {
            return nil
        }
        
        var queryParameters: [String : String]? {
            switch type {
            case .fetchBook(let isbnCode):
                return ["isbn": isbnCode]
            }
        }
        
        var body: Data? {
            return nil
        }
        
        var timeoutInterval: Int? {
            return nil
        }
    }
}
