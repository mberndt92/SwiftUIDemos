//
//  ContentView.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 22.05.23.
//

import SwiftUI

struct ContentView: View {
    
    enum Projects: String, CaseIterable {
        case SportsCircleTransition = "Sports Circle Transition"
        case AnimatingZIndex = "Animating zIndex"
        case AnimatingFontView = "Animating Font"
        case AnimatingNumbersWithFractions = "Animating Numbers with Fractions"
        case AnimatedTypeWriter = "Animated TypeWriter"
        case EdgeBounceView = "Edge Bounce"
        case WithMotionAnimationView = "With Motion Animation"
        case TwitterHeartAnimationView = "Twitter Hear Animation"
        case RequiredTextView = "Required Text"
        case StrokeWidthPlusFontEnvKey = "Stroke Width + Font (Env Key)"
        case StrokeWidthPlusFontEnvObject = "Stroke Width + Font (Env Object)"
        case PreferenceKey = "Preference Key"
        case AnchorPreferenceAirBnBAnimation = "Anchor Preference (AirBnB Animation)"
        case AdaptiveLayoutView = "Adaptive Layout"
        case RadialLayoutView = "Radial Layout"
        case EqualWidthHStack = "Equal Width HStack"
        case RelativeWidthLayout = "Relative Width Layout"
        case MasonryLayout = "Masonry Layout"
        
        @ViewBuilder
        func view() -> some View {
            switch self {
            case .AdaptiveLayoutView: AdaptiveLayout()
            case .AnchorPreferenceAirBnBAnimation: AnchorPreferenceView()
            case .AnimatedTypeWriter: AnimatableTypeWriter()
            case .AnimatingFontView: AnimatingFont()
            case .AnimatingNumbersWithFractions: AnimatableFractions()
            case .AnimatingZIndex: AnimatingTheUnanimatable()
            case .EdgeBounceView: EdgeBounce()
            case .EqualWidthHStack: EqualWidthHStackProject()
            case .MasonryLayout: MasonryLayoutProject()
            case .PreferenceKey: PreferenceKeyView()
            case .RadialLayoutView: CustomRadialLayout()
            case .RelativeWidthLayout: RelativeLayoutProject()
            case .RequiredTextView: RequiredText()
            case .SportsCircleTransition: SportsCircleTransitions()
            case .StrokeWidthPlusFontEnvKey: StrokeWidthShapes()
            case .StrokeWidthPlusFontEnvObject: StrokeWidthShapesEnvObject()
            case .TwitterHeartAnimationView: TwitterHeartAnimation()
            case .WithMotionAnimationView: WithMotionAnimation()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Projects.allCases, id: \.self) { view in
                    NavigationLink(view.rawValue) {
                        view.view()
                            .navigationTitle(view.rawValue)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
