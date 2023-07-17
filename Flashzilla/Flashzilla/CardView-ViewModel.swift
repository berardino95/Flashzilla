//
//  CardView-ViewModel.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 17/07/23.
//

import Foundation

extension ContentView{
    @MainActor class ViewModel : ObservableObject {
        
        @Published var cards = Array<Card>(repeating: Card.example, count: 10)
        
        func removeCard(at index: Int) {
            cards.remove(at: index)
        }
        
    }
}
