//
//  StrokeWidthShapes.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 25.05.23.
//

import SwiftUI

struct StrokeWidthKey: EnvironmentKey {
    static var defaultValue = 1.0
}

extension EnvironmentValues {
    var strokeWidth: Double {
        get { self[StrokeWidthKey.self] }
        set { self[StrokeWidthKey.self] = newValue }
    }
}

extension View {
    func strokeWidth(_ width: Double) -> some View {
        return environment(\.strokeWidth, width)
    }
}

struct CirclesView: View {
    @Environment(\.strokeWidth) var strokeWidth
    
    var body: some View {
        ForEach(0..<3) { _ in
            Circle()
                .stroke(.red, lineWidth: strokeWidth)
        }
    }
}

struct TitleFontKey: EnvironmentKey {
    static var defaultValue = Font.custom("Georgia", size: 34)
}

extension EnvironmentValues {
    var titleFont: Font {
        get { self[TitleFontKey.self] }
        set { self[TitleFontKey.self] = newValue }
    }
}

extension View {
    func titleFont(_ font: Font) -> some View {
        environment(\.titleFont, font)
    }
}

struct StrokeWidthShapes: View {
    
    @State private var sliderValue = 1.0
    @State private var titleFont = Font.largeTitle
    
    var body: some View {
        VStack {
            CirclesView()
            
            Text("Hello, world!")
                .font(titleFont)
            
            Slider(value: $sliderValue, in: 1...30)
            
            Button("Default Font") {
                titleFont = .largeTitle
            }
            
            Button("Custom Font") {
                titleFont = TitleFontKey.defaultValue
            }
        }
        .padding()
        .strokeWidth(sliderValue)
        .titleFont(titleFont)
    }
}

struct StrokeWidthShapes_Previews: PreviewProvider {
    static var previews: some View {
        StrokeWidthShapes()
    }
}
