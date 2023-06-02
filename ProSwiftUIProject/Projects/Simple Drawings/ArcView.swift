//
//  ArcView.swift
//  Drawing
//
//  Created by Maximilian Berndt on 2023/03/30.
//

import SwiftUI

struct Arc: InsettableShape {
    var insetAmount = 0.0
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ArcView: View {
    
    @State private var startAngle = 270.0
    @State private var endAngle = 90.0
    
    @State private var strokeBorderHue = 0.3
    @State private var lineWidth = 40.0
    
    
    var body: some View {
        VStack {
            Arc(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: true)
                .strokeBorder(Color(hue: strokeBorderHue, saturation: 1, brightness: 1), lineWidth: lineWidth)
            
            Text("Start Angle")
            Slider(value: $startAngle, in: 0...360)
            
            Text("End Angle")
            Slider(value: $endAngle, in: 0...360)
            
            Text("Stroke border hue")
            Slider(value: $strokeBorderHue)
            
            Text("Stroke border width")
            Slider(value: $lineWidth, in: 1...180)
            
        }
        .padding()
        .navigationTitle("Arc")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView()
    }
}
