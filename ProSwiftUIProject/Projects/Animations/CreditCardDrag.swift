//
//  CreditCardDrag.swift
//  Animations
//
//  Created by Maximilian Berndt on 2023/03/17.
//

import SwiftUI

struct CreditCardDrag: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount =  $0.translation }
                        .onEnded { _ in
                            withAnimation { // animate only reversing
                                dragAmount = .zero
                            }
                            
                        }
                )
            //            .animation(.spring(), value: dragAmount) // animate all
        }
        .navigationTitle("Credit Card Drag")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreditCardDrag_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardDrag()
    }
}
