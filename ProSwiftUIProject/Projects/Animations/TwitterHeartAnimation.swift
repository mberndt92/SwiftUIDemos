//
//  TwitterHeartAnimation.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 24.05.23.
//

import SwiftUI

struct ConfettiModifier<T: ShapeStyle>: ViewModifier {
    private let speed = 0.3
    
    // because scaling from 0.0 to 1 is not possible
    @State private var circleSize = 0.00001
    @State private var strokeMultiplier = 1.0
    
    @State private var isConfettiHidden = true
    @State private var confettiMovement = 0.7
    @State private var confettiScale = 1.0
    
    @State private var contentScale = 0.00001
    
    var color: T
    var size: Double
    
    func body(content: Content) -> some View {
        return content
            .hidden()
            .padding(10)
            .overlay(
                ZStack {
                    GeometryReader { proxy in
                        Circle()
                            .strokeBorder(color, lineWidth: (proxy.size.width / 2) * strokeMultiplier)
                            .scaleEffect(circleSize)
                        
                        ForEach(0..<15) { i in
                            Circle()
                                .fill(color)
                                .frame(width: size + sin(Double(i)), height: size + sin(Double(i)))
                                .scaleEffect(confettiScale)
                                .offset(x: proxy.size.width / 2 * confettiMovement + (i.isMultiple(of: 2) ? size : 0))
                                .rotationEffect(.degrees(24 * Double(i)))
                                .offset(x: (proxy.size.width - 2) / 2, y: (proxy.size.height - size) / 2)
                                .opacity(isConfettiHidden ? 0 : 1)
                        }
                    }
                    content
                        .scaleEffect(contentScale)
                }
            )
            .padding(-10)
            .onAppear {
                withAnimation(.easeIn(duration: speed)) {
                    circleSize = 1
                }
                withAnimation(.easeOut(duration: speed).delay(speed)) {
                    strokeMultiplier = 0.00001
                }
                
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5).delay(speed)) {
                    contentScale = 1
                }
                
                withAnimation(.easeOut(duration: speed).delay(speed * 1.25)) {
                    isConfettiHidden = false
                    confettiMovement = 1.2
                }
                withAnimation(.easeOut(duration: speed).delay(speed * 2)) {
                    confettiScale = 0.00001
                }
                
            }
    }
}

extension AnyTransition {
    static var confetti: AnyTransition {
        .modifier(active: ConfettiModifier(color: .blue, size: 3), identity: ConfettiModifier(color: .blue, size: 3))
    }
    
    static func confetti<T: ShapeStyle>(color: T = .blue, size: Double = 3.0) -> AnyTransition {
        .modifier(active: ConfettiModifier(color: color, size: size), identity: ConfettiModifier(color: color, size: size))
    }
}

struct TwitterHeartAnimation: View {
    
    @State private var isFavorite = false
    
    var body: some View {
        VStack(spacing: 60) {
            ForEach([Font.body, Font.largeTitle, Font.system(size: 72)], id: \.self) { font in
                Button {
                    isFavorite.toggle()
                } label: {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .transition(.confetti(color: .angularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center, startAngle: .zero, endAngle: .degrees(360)), size: 3))
                    } else {
                        Image(systemName: "heart")
                            .foregroundStyle(.gray)
                    }
                }
                .font(font)
            }
        }
    }
}

struct TwitterHeartAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TwitterHeartAnimation()
    }
}
