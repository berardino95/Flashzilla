//
//  CardView.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 17/07/23.
//

import SwiftUI

struct CardView: View {
    
    @StateObject var vm = ViewModel()
    
    let card : Card
    var removal: ((Bool) -> Void)? = nil
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var VoiceOverEnabled

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor ? .white : .white.opacity(1 - Double(abs(vm.offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor ? nil : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(using: vm.offset)
                )
                .shadow(radius: 10)
            
            VStack {
                if VoiceOverEnabled {
                    Text(vm.isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if vm.isShowingAnswer {
                        Spacer().frame(height: 30)
                        
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(30)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(vm.offset.width / 5)))
        .offset(x: vm.offset.width * 5, y : 0)
        .opacity(2 - Double(abs(vm.offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    vm.offset = gesture.translation
                    vm.feedback.prepare()
                }
                .onEnded{ _ in
                    if abs(vm.offset.width) > 100 {
                        if vm.offset.width < 0 {
                            vm.feedback.notificationOccurred(.error)
                            removal?(true)
                            vm.offset = .zero
                            vm.isShowingAnswer = false
                        } else {
                            removal?(false)
                        }
                    } else {
                        vm.offset = .zero
                    }
                }
        )
        .onTapGesture {
            withAnimation {
                vm.isShowingAnswer.toggle()
            }
            
        }
        .animation(.spring(), value: vm.offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
