//
//  Projects.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 02.06.23.
//

import Foundation
import SwiftUI

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
    case GlowingParticles = "Glowing Particles"
    case FallingSnow = "Falling Snow"
    case LavaLamp = "Lava Lamp"
    case LavaLampMath = "Lava Lamp Math"
    case BackgroundBlob = "Background Blob"
    case SpriteKit = "Sprite Kit"
    
    static func animations() -> [Projects] {
        return [
            .SportsCircleTransition,
            .AnimatingZIndex,
            .AnimatingFontView,
            .AnimatingNumbersWithFractions,
            .AnimatedTypeWriter,
            .EdgeBounceView,
            .WithMotionAnimationView,
            .TwitterHeartAnimationView
        ]
    }
    
    static func globalSettings() -> [Projects] {
        return [
            .RequiredTextView,
            .StrokeWidthPlusFontEnvKey,
            .StrokeWidthPlusFontEnvObject,
            .PreferenceKey,
            .AnchorPreferenceAirBnBAnimation
        ]
    }
    
    static func layouts() -> [Projects] {
        return [
            .AdaptiveLayoutView,
            .RadialLayoutView,
            .EqualWidthHStack,
            .RelativeWidthLayout,
            .MasonryLayout
        ]
    }
    
    static func drawings() -> [Projects] {
        return [
            .GlowingParticles,
            .FallingSnow,
            .LavaLamp,
            .LavaLampMath,
            .BackgroundBlob,
            .SpriteKit
        ]
    }
    
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .AdaptiveLayoutView: AdaptiveLayout()
        case .AnchorPreferenceAirBnBAnimation: AnchorPreferenceView()
        case .AnimatedTypeWriter: AnimatableTypeWriter()
        case .AnimatingFontView: AnimatingFont()
        case .AnimatingNumbersWithFractions: AnimatableFractions()
        case .AnimatingZIndex: AnimatingTheUnanimatable()
        case .BackgroundBlob: BackgroundAnimationBlurProject()
        case .EdgeBounceView: EdgeBounce()
        case .EqualWidthHStack: EqualWidthHStackProject()
        case .FallingSnow: FallingSnowProject()
        case .GlowingParticles: GlowingParticlesProject()
        case .LavaLamp: LavaLampProject()
        case .LavaLampMath: LavaLampMathProject()
        case .MasonryLayout: MasonryLayoutProject()
        case .PreferenceKey: PreferenceKeyView()
        case .RadialLayoutView: CustomRadialLayout()
        case .RelativeWidthLayout: RelativeLayoutProject()
        case .RequiredTextView: RequiredText()
        case .SportsCircleTransition: SportsCircleTransitions()
        case .SpriteKit: SpriteKitProject()
        case .StrokeWidthPlusFontEnvKey: StrokeWidthShapes()
        case .StrokeWidthPlusFontEnvObject: StrokeWidthShapesEnvObject()
        case .TwitterHeartAnimationView: TwitterHeartAnimation()
        case .WithMotionAnimationView: WithMotionAnimation()
        }
    }
}
