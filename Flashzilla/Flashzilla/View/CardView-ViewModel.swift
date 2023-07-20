//
//  CardView-ViewModel.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 18/07/23.
//

import Foundation
import UIKit

extension CardView {
    
    @MainActor class ViewModel : ObservableObject {
        
        @Published var isShowingAnswer = false
        @Published var offset = CGSize.zero
        @Published var feedback = UINotificationFeedbackGenerator()
        
    }
    
    
}
