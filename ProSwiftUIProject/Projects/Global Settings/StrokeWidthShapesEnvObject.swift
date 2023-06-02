//
//  StrokeWidthShapesEnvObject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 25.05.23.
//

import SwiftUI

protocol Theme {
    var strokeWidth: Double { get set }
    var titleFont: Font { get set }
}

struct DefaultTheme: Theme {
    var strokeWidth: Double = 1.0
    var titleFont: Font = TitleFontKey.defaultValue
}

class ThemeManager: ObservableObject {
    @Published var activeTheme: any Theme = DefaultTheme()
    
    static var shared = ThemeManager()
    private init() { }
}

struct ThemeKey: EnvironmentKey {
    static var defaultValue: any Theme = ThemeManager.shared.activeTheme
}

extension EnvironmentValues {
    var theme: any Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// Needed to have an observed object to watch for changes
struct ThemeModifier: ViewModifier {
    @ObservedObject var themeManager = ThemeManager.shared
    
    func body(content: Content) -> some View {
        content.environment(\.theme, themeManager.activeTheme)
    }
}

extension View {
    func themed() -> some View {
        modifier(ThemeModifier())
    }
}

struct CirclesViewEnvObject: View {
    // Only watch for necessary changes to not re-invoke the body with EVERY theme change.
    @Environment(\.theme.strokeWidth) var strokeWidth
    
    var body: some View {
        ForEach(0..<3) { _ in
            Circle()
                .stroke(.red, lineWidth: strokeWidth)
        }
    }
}

struct StrokeWidthShapesEnvObject: View {
    
    @ObservedObject var theme = ThemeManager.shared
    
    var body: some View {
        VStack {
            CirclesViewEnvObject()
            
            Text("Hello, world!")
                .font(theme.activeTheme.titleFont)
            
            Slider(value: $theme.activeTheme.strokeWidth, in: 1...30)
            
            Button("Default Font") {
                theme.activeTheme.titleFont = .largeTitle
            }
            
            Button("Custom Font") {
                theme.activeTheme.titleFont = TitleFontKey.defaultValue
            }
        }
        .padding()
        .themed()
    }
}

struct StrokeWidthShapesEnvObject_Previews: PreviewProvider {
    static var previews: some View {
        StrokeWidthShapesEnvObject()
    }
}
