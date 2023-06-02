//
//  SnakeHelloWorld.swift
//  Animations
//
//  Created by Maximilian Berndt on 2023/03/17.
//

import SwiftUI

struct SnakeHelloWorldView: View {
    let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(
                            .default.delay(Double(num) / 20),
                            value: dragAmount
                        )
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )
        }
        .navigationTitle("Snake Hello World")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SnakeHelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeHelloWorldView()
    }
}
