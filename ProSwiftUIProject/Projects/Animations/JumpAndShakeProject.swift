//
//  JumpAndShakeProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 11.06.23.
//

import SwiftUI

struct JumpAndShakeProject: View {
    
    @State private var startKeyFrameAnimation = false
    
    var body: some View {
        VStack(spacing: 50) {
            ZStack {
                Circle()
                    .fill(.cyan)
                    .frame(width: 200)
                
                Image(systemName: "figure.handball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(.white)
                    .padding(25)
            }
            .keyframeAnimator(initialValue: KeyFrame(), trigger: startKeyFrameAnimation) { view, frame in
                view
                    .scaleEffect(frame.scale)
                    .rotationEffect(frame.rotation, anchor: .bottom)
                    .offset(y: frame.yOffset)
            } keyframes: { frame in
                
                KeyframeTrack(\.yOffset) {
                    CubicKeyframe(10, duration: 0.15)
                    SpringKeyframe(-110, duration: 0.3, spring: .bouncy)
                    CubicKeyframe(-110, duration: 0.45)
                    SpringKeyframe(0, duration: 0.3, spring: .bouncy)
                }
                
                KeyframeTrack(\.scale) {
                    CubicKeyframe(0.8, duration: 0.15)
                    CubicKeyframe(1.2, duration: 0.3)
                    CubicKeyframe(1.2, duration: 0.3)
                    CubicKeyframe(1.0, duration: 0.3)
                }
                
                KeyframeTrack(\.rotation) {
                    CubicKeyframe(.zero, duration: 0.45)
                    CubicKeyframe(.degrees(-20), duration: 0.1)
                    CubicKeyframe(.degrees(20), duration: 0.1)
                    CubicKeyframe(.degrees(-20), duration: 0.1)
                    CubicKeyframe(.degrees(0), duration: 0.1)
                }
            }

            
            Button("Animate Me!") {
                withAnimation {
                    startKeyFrameAnimation.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    struct KeyFrame {
        var scale = 1.0
        var yOffset = 0.0
        var rotation: Angle = .zero
    }
}

#Preview {
    JumpAndShakeProject()
}
