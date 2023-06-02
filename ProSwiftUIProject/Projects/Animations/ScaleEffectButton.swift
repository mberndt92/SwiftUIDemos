//
//  ScaleEffectButton.swift
//  Animations
//
//  Created by Maximilian Berndt on 2023/03/17.
//

import SwiftUI

struct ScaleEffectButton: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeOut(duration: 0.5)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
                .padding()
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        .navigationTitle("Scale Effect Button")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScaleEffectButton_Previews: PreviewProvider {
    static var previews: some View {
        ScaleEffectButton()
    }
}
