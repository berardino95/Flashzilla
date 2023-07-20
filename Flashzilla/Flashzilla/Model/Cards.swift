//
//  Cards.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 19/07/23.
//

import Foundation

@MainActor class Cards : ObservableObject {
    
    @Published fileprivate(set) var data = [Card]()

}
