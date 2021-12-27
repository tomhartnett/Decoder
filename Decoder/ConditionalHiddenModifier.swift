//
//  ConditionalHiddenModifier.swift
//  Decoder
//
//  Created by Tom Hartnett on 12/27/21.
//

import SwiftUI

struct ConditionalHiddenModifier: ViewModifier {
    var isHidden = false

    func body(content: Content) -> some View {
        if isHidden {
            // Don't render at all
        } else {
            content
        }
    }
}

extension View {
    func hideIf(_ isHidden: Bool) -> some View {
        self.modifier(ConditionalHiddenModifier(isHidden: isHidden))
    }
}
