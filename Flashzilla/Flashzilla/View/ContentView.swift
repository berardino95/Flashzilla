//
//  ContentView.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 16/07/23.
//

import CoreHaptics
import SwiftUI



struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var VoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                
                Text(vm.timeRemaining > 0 ? "Time: \(vm.timeRemaining)" : "Time finished")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.6))
                    .clipShape(Capsule())
                
                ZStack{
                    ForEach(Array(vm.cards.enumerated()), id: \.element) { item in
                        //item element is the element containing the data
                        CardView(card: item.element ){ reinsert in
                            withAnimation{
                                //item.offset coming from Hashable conformance
                                vm.removeCard(at: item.offset, reinsert: reinsert)
                            }
                        }
                        .stacked(at: item.offset, in: vm.cards.count)
                        .allowsHitTesting(item.offset == vm.cards.count - 1)
                        .accessibilityHidden(item.offset < vm.cards.count - 1)
                    }
                }
                .allowsHitTesting(vm.timeRemaining > 0)
                
                //Button Restart Game
                if vm.cards.isEmpty {
                    Spacer().frame(height: 50)
                    Button("Restart game") { vm.resetCards() }
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            //Plus button
            VStack{
                HStack{
                    if !vm.cards.isEmpty {
                        Button{
                            vm.resetCards()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                    Button{
                        vm.showEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            .sheet(isPresented: $vm.showEditScreen, onDismiss: vm.resetCards) {
                EditCardView()
            }
            
            
            //This view is visible only when differentiateWithoutColor or voiceOver is enable
            if differentiateWithoutColor || VoiceOverEnabled {
                VStack{
                    Spacer()
                    
                    HStack{
                        Button {
                            vm.removeCard(at: vm.cards.count - 1, reinsert: true)
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        
                        Spacer()
                        
                        Button {
                            vm.removeCard(at: vm.cards.count - 1, reinsert: false)
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Right")
                        .accessibilityHint("Mark your answer as being correct")
                        
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
                .allowsHitTesting(vm.timeRemaining > 0)
            }
        }
        //modifier to work with a timer
        .onReceive(vm.timer) { time in
            //Stopping the time if isActive is not true(every time the app isn't in foreground)
            guard vm.isActive else { return }
            
            if vm.timeRemaining > 0 {
                vm.timeRemaining -= 1
            } else {
                vm.timer.upstream.connect().cancel()
            }
        }
        //on change of scenePhase toggle isActive
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if vm.cards.isEmpty == false {
                    vm.isActive = true
                }
            } else {
                vm.isActive = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
