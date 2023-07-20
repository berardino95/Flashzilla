//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Berardino Chiarello on 19/07/23.
//

import SwiftUI

struct EditCardView: View {
    
    @StateObject var vm = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    Section("Add new card"){
                        TextField("Prompt", text: $vm.prompt)
                        TextField("Answer", text: $vm.answer)
                        
                        HStack{
                            Spacer()
                            Button("Add card"){
                                withAnimation {
                                    vm.addCard()
                                }
                            }
                            .disabled(vm.isDisable)
                            Spacer()
                        }
                    }
                    if !vm.cards.isEmpty {
                        Section("Your card"){
                            ForEach(0..<vm.cards.count, id: \.self) { index in
                                VStack(alignment: .leading){
                                    Text(vm.cards[index].prompt)
                                        .font(.title)
                                    Text(vm.cards[index].answer)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDelete(perform: removeCard)
                        }
                    }
                }
                .navigationTitle("Edit cards")
                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing){
                        Button("Done") { dismiss() }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }
    func removeCard(at offsets : IndexSet){
        vm.deleteCard(at: offsets)
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
