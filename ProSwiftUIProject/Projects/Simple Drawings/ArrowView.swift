//
//  ArrorView.swift
//  Drawing
//
//  Created by Maximilian Berndt on 2023/03/29.
//

import SwiftUI

struct Arrow: InsettableShape {
    
    var insetAmount = 0.0
    
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 2/3 to 1/3 proportion
        let triangleHeight = (rect.maxY / 3) * 1
        
        let rectWidth = rect.width / 2
        
        let maxY = rect.maxY - insetAmount
        let maxX = rect.maxX - insetAmount
        let minY = rect.minY + insetAmount
        let minX = rect.minX + insetAmount
        
        // Draw rectangle
        path.move(to: CGPoint(x: rect.minX + rectWidth / 2, y: maxY))
        path.addLine(to: CGPoint(x: rect.maxX - rectWidth / 2, y: maxY))
        path.addLine(to: CGPoint(x: rect.maxX - rectWidth / 2, y: rect.minY + triangleHeight))
        path.addLine(to: CGPoint(x: rect.minX + rectWidth / 2, y: rect.minY + triangleHeight))
        path.addLine(to: CGPoint(x: rect.minX + rectWidth / 2, y: maxY))
        
        // Draw triangle
        path.move(to: CGPoint(x: rect.minX + rectWidth / 2, y: rect.minY + triangleHeight))
        path.addLine(to: CGPoint(x: minX, y: rect.minY + triangleHeight))
        path.addLine(to: CGPoint(x: rect.midX, y: minY))
        path.addLine(to: CGPoint(x: maxX, y: rect.minY + triangleHeight))
        path.addLine(to: CGPoint(x: rect.minX + rectWidth / 2, y: rect.minY + triangleHeight))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        
        return arrow
    }
}

struct ArrowView: View {
    
    @State private var lineWidth = 5.0
    
    var body: some View {
        VStack {
            Arrow()
                .strokeBorder(Color.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            
            Spacer()
            
            Button("Randomize line width") {
                withAnimation {
                    lineWidth = Double.random(in: 1...30)
                }
            }
        }
        .padding()
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
