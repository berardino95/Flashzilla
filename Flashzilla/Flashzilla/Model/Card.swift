//
//  Card.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 17/07/23.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    
    enum CodingKeys :String, CodingKey {
        case prompt, answer
    }
    
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
