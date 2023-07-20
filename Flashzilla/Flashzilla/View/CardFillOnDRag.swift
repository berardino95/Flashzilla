//
//  CardFillOnDRag.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 20/07/23.
//

import SwiftUI

extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            return self.fill(.white)
        } else if offset.width > 0 {
            return self.fill(.green)
        } else {
            return self.fill(.red)
        }
    }
}
