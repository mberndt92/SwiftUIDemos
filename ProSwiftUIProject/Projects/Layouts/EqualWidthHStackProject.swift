//
//  EqualWidthHStackProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 29.05.23.
//

import SwiftUI

struct EqualWidthHStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let size = maximumSize(across: subviews)
        let spacing = spacing(for: subviews).reduce(0, +)
        
        return CGSize(
            width: size.width * Double(subviews.count) + spacing,
            height: size.height
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maximumSize(across: subviews)
        let spacing = spacing(for: subviews)
        
        let proposal = ProposedViewSize(
            width: maxSize.width,
            height: maxSize.height
        )
        
        var x = bounds.minX + maxSize.width / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY), anchor: .center, proposal: proposal)
            x += maxSize.width + spacing[index]
        }
        
    }
    
    private func maximumSize(across subviews: Subviews) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        return sizes.reduce(.zero) { largest, next in
            CGSize(
                width: max(largest.width, next.width),
                height: max(largest.height, next.height)
            )
        }
    }
    
    private func spacing(for subviews: Subviews) -> [Double] {
        return subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0.0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
        }
    }
}

struct EqualWidthHStackProject: View {
    var body: some View {
        VStack(spacing: 40) {
            // Containers are equal size, text naturally still only width fitting text
            EqualWidthHStack {
                Text("Short")
                    .background(.red)
                Text("This is long")
                    .background(.green)
                Text("This is longest")
                    .background(.blue)
            }
            
            HStack {
                Text("Short")
                    .background(.red)
                Text("This is long")
                    .background(.green)
                Text("This is longest")
                    .background(.blue)
            }
        }
    }
}

struct EqualWidthHStackProject_Previews: PreviewProvider {
    static var previews: some View {
        EqualWidthHStackProject()
    }
}
