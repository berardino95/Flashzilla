//
//  DataManager.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 20/07/23.
//

import Foundation

struct DataManager {
    
    
    static let saveURL = FileManager.documentDirectory.appendingPathComponent("saveKey")
    
    
    static func loadCard() -> [Card]{
        let standardQuestions : [Card] = Bundle.main.decode("cards.json")

        if let data = try? Data(contentsOf: saveURL){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                if !decoded.isEmpty{
                    return decoded
                } else {
                    
                    return standardQuestions
                }
            }
        }
        return []
    }
    
    static func save(_ cards: [Card]){
        if let data = try? JSONEncoder().encode(cards){
            try? data.write(to: saveURL, options: [.atomic, .completeFileProtection])
        }
    }
}


