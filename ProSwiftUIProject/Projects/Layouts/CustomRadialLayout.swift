//
//  CustomRadialLayout.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 29.05.23.
//

import SwiftUI

struct RadialLayout: Layout {
    
    var rollout = 0.0
    
    // with this, expanding happens --along-- the circle. - size that fits and place subviews called many times
    // without it, animation goes outward from old to new position simply - bc rollout is just changed from 0 to 1 e.g
    var animatableData: Double {
        get { rollout }
        set { rollout = newValue }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.size.width, bounds.size.height) / 2
        let angle = Angle.degrees(360 / Double(subviews.count)).radians * rollout
        
        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)
            
            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
            
            let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
            
            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct CustomRadialLayout: View {
    
    @State private var count = 16
    @State private var isExpanded = false
    
    var body: some View {
        RadialLayout(rollout: isExpanded ? 1 : 0) {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .frame(width: 32, height: 32)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
                .padding()
            
            Button("Expand") {
                withAnimation(.easeInOut(duration: 1)) {
                    isExpanded.toggle()
                }
            }
        }
    }
}

struct CustomRadialLayout_Previews: PreviewProvider {
    static var previews: some View {
        CustomRadialLayout()
    }
}
