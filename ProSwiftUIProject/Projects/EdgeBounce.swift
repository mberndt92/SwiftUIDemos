//
//  EdgeBounce.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 23.05.23.
//

import SwiftUI

// Use https://cubic-bezier.com/#.17,.67,.83,.67 for precise animation tuning
extension Animation {
    static var edgeBounce: Animation {
        Animation.timingCurve(0, 1, 1, 0)
    }
    
    static func edgeBounce(duration: TimeInterval = 0.2) -> Animation {
        return Animation.timingCurve(0, 1, 1, 0, duration: duration)
    }
}

struct EdgeBounce: View {
    @State private var offset = -200.0
    
    var body: some View {
        Text("Hello World!")
            .font(.largeTitle)
            .offset(y: offset)
            .animation(.edgeBounce(duration: 2).repeatForever(autoreverses: true), value: offset)
            .onTapGesture {
                offset = 200.0
            }
    }
}

struct EdgeBounce_Previews: PreviewProvider {
    static var previews: some View {
        EdgeBounce()
    }
}
