//
//  AnimatableFractions.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 23.05.23.
//

import SwiftUI

struct CountingText: View, Animatable {
    var value: Double
    var fractionLength = 8
    
    var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    
    var body: some View {
        Text(value.formatted(.number.precision(.fractionLength(fractionLength))))
    }
    
}

struct AnimatableFractions: View {
    
    @State private var value = 0.0
    
    var body: some View {
        CountingText(value: value)
            .font(.largeTitle)
            .onTapGesture {
                withAnimation(.linear) {
                    value = Double.random(in: 0...1000)
                }
            }
    }
}

struct AnimatableFractions_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableFractions()
    }
}
