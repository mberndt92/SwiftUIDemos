//
//  PulsingButton.swift
//  Animations
//
//  Created by Maximilian Berndt on 2023/03/16.
//

import SwiftUI

struct PulsingButtonProject: View {
    @State private var animationAmount = 1.0
    @State private var isNavigationHidden = true
    
    private var simulatorOffset = 10.0
    
    var body: some View {
        GeometryReader { geometry in
            Button("Toggle") {
                withAnimation {
                    isNavigationHidden.toggle()
                }
            }
                .padding(50)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animationAmount)
                        .offset(y: simulatorOffset) // hack - somehow not centering otherwise
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2 )
                .onAppear {
                    animationAmount = 2
                }
                .navigationTitle("Pulsing Button")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(isNavigationHidden)
        }
    }
}

struct PulsingButtonProject_Previews: PreviewProvider {
    static var previews: some View {
        PulsingButtonProject()
    }
}
