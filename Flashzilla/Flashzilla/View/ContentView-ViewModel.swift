//
//  CardView-ViewModel.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 17/07/23.
//

import Foundation
import UIKit

extension ContentView{
    @MainActor class ViewModel : ObservableObject {
        
        @Published var cards = DataManager.loadCard()
        
        @Published var timeRemaining = 100
        @Published var isActive = false
        
        @Published var feedback = UINotificationFeedbackGenerator()
        @Published var showEditScreen = false
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        
        func removeCard(at index: Int, reinsert: Bool) {
            guard index >= 0 else { return }
            
            if reinsert{
                cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
            } else {                
                cards.remove(at: index)
            }
            
            if cards.isEmpty {
                isActive = false
            }
        }
        
        func resetCards(){
            feedback.notificationOccurred(.success)
            cards = DataManager.loadCard()
            timeRemaining = 100
            isActive = true
        }
        
    }
}
