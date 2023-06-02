//
//  MasonryLayoutProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 30.05.23.
//

import SwiftUI

struct MasonryLayout: Layout {
    struct Cache {
        var frames: [CGRect]
        var width = 0.0
    }
    
    var columns: Int
    var spacing: Double
    
    // This is default assumption but in case we gotta define an explicit layout implementation
    static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        return properties
    }
    
    init(columns: Int = 3, spacing: Double = 5) {
        self.columns = max(1, columns)
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for: subviews, in: width)
        let bottomView = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        
        cache.frames = viewFrames
        cache.width = width
        
        return CGSize(width: width, height: bottomView.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        
        if cache.width != bounds.width {
            cache.frames = frames(for: subviews, in: bounds.width)
            cache.width = bounds.width
        }
        
        for index in subviews.indices {
            let frame = cache.frames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY)
            // anchor: .topLeading is default but adding it here explicitly for verbosity
            subviews[index].place(at: position, anchor: .topLeading, proposal: ProposedViewSize(frame.size))
        }
    }
    
    private func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
        let totalSpacing = spacing * Double(columns - 1)
        let columnWidth = (totalWidth - totalSpacing) / Double(columns)
        let columnWidthWithSpacing = columnWidth + spacing
        let proposedSize = ProposedViewSize(width: columnWidth, height: nil)
        
        // Placement of views in Masonry layout is actually "quite clever", not just random
        var viewFrames = [CGRect]()
        var columnHeights = Array(repeating: 0.0, count: columns)
        
        for subview in subviews {
            var selectedColumn = 0
            var selectedHeight = Double.greatestFiniteMagnitude
            
            for (columnIndex, height) in columnHeights.enumerated() {
                if height < selectedHeight {
                    selectedColumn = columnIndex
                    selectedHeight = height
                }
            }
            
            let x = Double(selectedColumn) * columnWidthWithSpacing
            let y = columnHeights[selectedColumn]
            let size = subview.sizeThatFits(proposedSize)
            let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            
            columnHeights[selectedColumn] += size.height + spacing
            viewFrames.append(frame)
        }
        
        return viewFrames
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache(frames: [])
    }
}

struct PlaceholderView: View {
    let color: Color = [.blue, .cyan, .green, .indigo, .mint, .orange, .pink, .purple, .red].randomElement()!
    let size: CGSize
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            
            Text("\(Int(size.width))x\(Int(size.height))")
                .foregroundColor(.white)
                .font(.headline)
                .minimumScaleFactor(0.5)
        }
        .aspectRatio(size, contentMode: .fill)
    }
}

struct MasonryLayoutProject: View {
    @State private var columns = 3
    
    @State private var views = (0..<20).map { _ in
        CGSize(width: .random(in: 100...500), height: .random(in: 100...500))
    }
    
    var body: some View {
        ScrollView {
            MasonryLayout(columns: columns) {
                ForEach(0..<20) { i in
                    PlaceholderView(size: views[i])
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Columns: \(columns)", value: $columns.animation(), in: 1...5)
                .padding()
                .background(.regularMaterial)
        }
    }
}

struct MasonryLayoutProject_Previews: PreviewProvider {
    static var previews: some View {
        MasonryLayoutProject()
    }
}
