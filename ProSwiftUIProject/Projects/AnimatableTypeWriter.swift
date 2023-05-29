//
//  AnimatableTypeWriter.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 23.05.23.
//

import SwiftUI

struct TypeWriterText: View, Animatable {
    
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    
    var text: String
    var count = 0
    
    var animatableData: Double {
        get { Double(count) }
        set { count = Int(max(0, newValue)) }
    }
    
    var body: some View {
        let stringToShow = String(text.prefix(count))
        
        if accessibilityVoiceOverEnabled || accessibilityReduceMotion {
            Text(text)
        } else {
            // Assure we allocate the right space beforehand.
            ZStack {
                Text(text)
                    .hidden()
                    .overlay(
                        Text(stringToShow),
                        alignment: .topLeading
                    )
            }
        }
    }
}


struct AnimatableTypeWriter: View {
    @State private var count = 0
    let message = "This is a very long message that should be typed letter by letter."
    
    var body: some View {
        VStack(spacing: 8) {
            TypeWriterText(text: message, count: count)
                .frame(width: 300, alignment: .leading)
            
            Button("Type!") {
                withAnimation(.linear(duration: 2)) {
                    count = message.count
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Reset") {
                withAnimation(.linear(duration: 2)) {
                    count = 0
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct AnimatableTypeWriter_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableTypeWriter()
    }
}
