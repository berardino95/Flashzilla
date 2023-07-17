//
//  ContentView.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 16/07/23.
//

import CoreHaptics
import SwiftUI



struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                ZStack{
                    ForEach(0..<viewModel.cards.count, id: \.self) { index in
                        CardView(card: viewModel.cards[index]){
                            withAnimation{
                                viewModel.removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: viewModel.cards.count)
                    }
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
