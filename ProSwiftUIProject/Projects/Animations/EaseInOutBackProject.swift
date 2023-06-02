//
//  EaseInOutBack.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 23.05.23.
//

import SwiftUI

// Use https://cubic-bezier.com/#.17,.67,.83,.67 for precise animation tuning
extension Animation {
    
    static var easeInOutBack: Animation {
        return Animation.timingCurve(0.7, -0.5, 0.3, 1.5)
    }
    
    static func easeInOutBack(duration: TimeInterval = 0.2) -> Animation {
        return Animation.timingCurve(0.7, -0.5, 0.3, 1.5, duration: duration)
    }
}

struct EaseInOutBackProject: View {
    @State private var offset = -200.0
    
    var body: some View {
        Text("Hello World!")
            .font(.largeTitle)
            .offset(y: offset)
            .animation(.easeInOutBack(duration: 2).repeatForever(autoreverses: true), value: offset)
            .onTapGesture {
                offset = 200.0
            }
    }
}

struct EaseInOutBackProject_Previews: PreviewProvider {
    static var previews: some View {
        EaseInOutBackProject()
    }
}
