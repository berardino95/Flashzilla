//
//  EditCard-ViewModle.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 19/07/23.
//

import Foundation
import SwiftUI

@MainActor class ViewModel : ObservableObject {
    
    @Published var cards = DataManager.loadCard()
    @Published var prompt = ""
    @Published var answer = ""
    
    var isDisable : Bool {
        if prompt.isEmpty || answer.isEmpty {
            return true
        } else {
            return false
        }
    }

    

    
    
    func addCard(){
        let newCard = Card(prompt: prompt, answer: answer)
        cards.insert(newCard, at: 0)
        DataManager.save(cards)
        
        prompt = ""
        answer = ""
    }
    
    func deleteCard(at offset: IndexSet){
        cards.remove(atOffsets: offset)
        DataManager.save(cards)
    }
  
}
