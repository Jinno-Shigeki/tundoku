//
//  Router.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import Foundation
import SwiftUI

@MainActor
@Observable
public final class Router {
    static let shared = Router()
    
    var path = NavigationPath()
    
    func push(_ type: ViewType) {
        path.append(type)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popRoot() {
        path = NavigationPath()
    }
}
