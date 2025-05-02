//
//  Request.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation

internal enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

internal protocol Request {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
    var timeoutInterval: Int? { get }
}

extension Request {
    private var defaultHeaders: [String: String] {
        ["Accept": "application/json", "Content-Type": "application/json"]
    }
    
    func make() throws -> URLRequest {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers ?? defaultHeaders
        request.httpBody = body
        if let timeoutInterval = timeoutInterval {
            request.timeoutInterval = TimeInterval(timeoutInterval)
        }
        return request
    }
    
    static func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}
