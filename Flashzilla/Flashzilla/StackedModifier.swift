//
//  StackedModifier.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 17/07/23.
//

import SwiftUI


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 5)
    }
}
