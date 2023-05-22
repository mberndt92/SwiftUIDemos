//
//  AnimatingFont.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 22.05.23.
//

import SwiftUI

// Before iOS16 font is not animatable but we can fix that!
struct AnimatableFontModifer: ViewModifier, Animatable {
    var size: Double
    
    var animatableData: Double {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableFont(_ size: Double) -> some View {
        self.modifier(AnimatableFontModifer(size: size))
    }
}

struct AnimatingFont: View {
    
    @State private var scaleUp = false
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .animatableFont(scaleUp ? 56 : 24)
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                        scaleUp.toggle()
                    }
                }
        }
    }
}

struct AnimatingFont_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingFont()
    }
}
