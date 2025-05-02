//
//  APIClient.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

struct APIClient {
    func run<T: Request>(request: T) async throws -> T.Response {
        let urlRequest = try request.make()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try T.decode(data)
    }
}
