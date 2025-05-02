//
//  RouterModifier.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/05/01.
//

import SwiftUI

struct RouterModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ViewType.self) { $0.makeView() }
    }
}

extension View {
    func applyRouter() -> some View {
        self.modifier(RouterModifier())
    }
}
