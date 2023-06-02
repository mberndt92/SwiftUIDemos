//
//  AnimatingTheUnanimatable.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 22.05.23.
//

import SwiftUI


/**
 // Two ways to use animatableData.
 1. use a variable in the modifier
 2. Just override animatableData directly
 
 */
struct AnimatableZIndexModifier: ViewModifier, Animatable {
    var index: Double
    
    var animatableData: Double {
        get { index }
        set { index = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .zIndex(index)
    }
}

struct AnimatableZIndexModifierShort: ViewModifier, Animatable {
    
    var animatableData: Double
    
    func body(content: Content) -> some View {
        content
            .zIndex(animatableData)
    }
}

extension View {
    func animatableZIndex(_ index: Double) -> some View {
        self.modifier(AnimatableZIndexModifier(index: index))
    }
    
    func animatableZIndexShort(_ index: Double) -> some View {
        self.modifier(AnimatableZIndexModifierShort(animatableData: index))
    }
}

struct AnimatingTheUnanimatable: View {
    
    @State private var redAtFront = false
    let colors: [Color] = [.blue, .green, .orange, .purple, .mint]
    
    var body: some View {
        VStack {
            Button("Toggle zIndex") {
                withAnimation(.linear(duration: 1)) {
                    redAtFront.toggle()
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red)
                    .animatableZIndexShort(redAtFront ? 6 : 0)
                
                ForEach(0..<5) { i in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colors[i])
                        .offset(x: Double(i + 1) * 20, y: Double(i + 1) * 20)
                        .zIndex(Double(i))
                }
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct AnimatingTheUnanimatable_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingTheUnanimatable()
    }
}
