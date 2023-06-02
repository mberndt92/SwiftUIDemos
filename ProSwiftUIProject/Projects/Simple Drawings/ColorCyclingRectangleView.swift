//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Maximilian Berndt on 2023/03/29.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    
    var amount = 0.0
    var steps: Int = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView: View {
    
    @State private var colorCycle = 0.0
    @State private var steps = 100.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle, steps: Int(steps))
                .frame(width: 300, height: 300)
            
            Group {
                Text("Color Cycle")
                Slider(value: $colorCycle)
                
                Text("Steps")
                Slider(value: $steps, in: 1...200)
            }
            
            
        }
        .navigationTitle("Color Cycling Rectangle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ColorCyclingRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
