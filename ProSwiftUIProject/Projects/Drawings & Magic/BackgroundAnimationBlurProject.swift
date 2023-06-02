//
//  BackgroundAnimationBlurProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 02.06.23.
//

import SwiftUI

struct BackgroundBlob: View {
    @State private var rotationAmount = 0.0
    let alignment: Alignment = [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing].randomElement()!
    let color: Color = [.blue, .cyan, .indigo, .mint, .purple, .teal].randomElement()!
    
    var body: some View {
        Ellipse()
            .fill(color)
            .frame(width: .random(in: 200...500), height: .random(in: 200...500))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .offset(x: .random(in: -400...400), y: .random(in: -400...400))
            .rotationEffect(.degrees(rotationAmount))
            .animation(
                .linear(duration: .random(in: 20...40)).repeatForever(),
                value: rotationAmount
            )
            .onAppear {
                rotationAmount = .random(in: -360...360)
            }
            .blur(radius: 75)
    }
}

struct BackgroundAnimationBlurProject: View {
    var body: some View {
        ZStack {
            ForEach(0..<15) { _ in
                BackgroundBlob()
            }
        }
        .background(.blue)
    }
}

struct BackgroundAnimationBlurProject_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAnimationBlurProject()
    }
}
