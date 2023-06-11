//
//  Projects.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 02.06.23.
//

import Foundation
import SwiftUI

enum GlobalSettingsProjects: String, CaseIterable {
    case AnchorPreferenceAirBnBAnimation = "Anchor Preference (AirBnB Animation)"
    case PreferenceKey = "Preference Key"
    case RequiredTextView = "Required Text"
    case StrokeWidthPlusFontEnvKey = "Stroke Width + Font (Env Key)"
    case StrokeWidthPlusFontEnvObject = "Stroke Width + Font (Env Object)"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .AnchorPreferenceAirBnBAnimation: AnchorPreferenceView()
        case .PreferenceKey: PreferenceKeyView()
        case .RequiredTextView: RequiredText()
        case .StrokeWidthPlusFontEnvKey: StrokeWidthShapes()
        case .StrokeWidthPlusFontEnvObject: StrokeWidthShapesEnvObject()
        }
    }
}

enum AnimationProjects: String, CaseIterable {
    case AnimatedTypeWriter = "Animated TypeWriter"
    case AnimatingFontView = "Animating Font"
    case AnimatingNumbersWithFractions = "Animating Numbers with Fractions"
    case AnimatingZIndex = "Animating zIndex"
    case AsymetricAnimation = "Asymetric Animation"
    case ButtonTransition = "ButtonTransition"
    case CreditCard = "Credit Card Drag"
    case EaseInOutBack = "Ease In Out Back"
    case EdgeBounceView = "Edge Bounce"
    case NetflixAnimation = "Netflix Profile Selection Animation"
    case NetflixAnimationKeyFrame = "Netflix Profile Selection Animation (KeyFrame)"
    case PresentationStyleAppear = "Presentation Style Appear (old school)"
    case PulsingButton = "Pulsing Button"
    case ScaleEffect = "Scale Effect"
    case Snake = "Snake Hello World"
    case SportsCircleTransition = "Sports Circle Transition"
    case TwitterHeartAnimationView = "Twitter Hear Animation"
    case WithMotionAnimationView = "With Motion Animation"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .AnimatedTypeWriter: AnimatableTypeWriter()
        case .AnimatingFontView: AnimatingFont()
        case .AnimatingNumbersWithFractions: AnimatableFractions()
        case .AnimatingZIndex: AnimatingTheUnanimatable()
        case .AsymetricAnimation: AsymetricAnimatedView()
        case .ButtonTransition: ButtonTransitionAnimationView()
        case .CreditCard: CreditCardDrag()
        case .EaseInOutBack: EaseInOutBackProject()
        case .EdgeBounceView: EdgeBounce()
        case .NetflixAnimation: NetflixAnimationProject()
        case .NetflixAnimationKeyFrame: NetflixAnimationProjectKeyFrames()
        case .PresentationStyleAppear: PresentationStyleAppearView()
        case .PulsingButton: PulsingButtonProject()
        case .ScaleEffect: ScaleEffectButton()
        case .Snake: SnakeHelloWorldView()
        case .SportsCircleTransition: SportsCircleTransitions()
        case .TwitterHeartAnimationView: TwitterHeartAnimation()
        case .WithMotionAnimationView: WithMotionAnimation()
        }
    }
}

enum CustomLayoutProjects: String, CaseIterable {
    case AdaptiveLayoutView = "Adaptive Layout"
    case EqualWidthHStack = "Equal Width HStack"
    case MasonryLayout = "Masonry Layout"
    case RadialLayoutView = "Radial Layout"
    case RelativeWidthLayout = "Relative Width Layout"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .AdaptiveLayoutView: AdaptiveLayout()
        case .EqualWidthHStack: EqualWidthHStackProject()
        case .MasonryLayout: MasonryLayoutProject()
        case .RadialLayoutView: CustomRadialLayout()
        case .RelativeWidthLayout: RelativeLayoutProject()
        }
    }
}

enum SimpleDrawingProjects: String, CaseIterable {
    case Arc = "Arc"
    case Arrow = "Arrow"
    case Blur = "Blur"
    case Checkerboard = "Checkerboard"
    case ColorCyclingCircle = "Color Cycling Circle"
    case ColorCyclingRectangle = "Color Cycling Rectangle"
    case Flower = "Flower"
    case ScreenBlender = "Screen Blender"
    case Trapezoid = "Trapezoid"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .Arc: ArcView()
        case .Arrow: ArrowView()
        case .Blur: BlurView()
        case .Checkerboard: CheckerboardView()
        case .ColorCyclingCircle: ColorCyclingCircleView()
        case .ColorCyclingRectangle: ColorCyclingRectangleView()
        case .Flower: FlowerView()
        case .ScreenBlender: ScreenBlenderView()
        case .Trapezoid: TrapezoidView()
        }
    }
}

enum DrawingMagicProjects: String, CaseIterable {
    case BackgroundBlob = "Background Blob"
    case FallingSnow = "Falling Snow"
    case GlowingParticles = "Glowing Particles"
    case LavaLamp = "Lava Lamp"
    case LavaLampMath = "Lava Lamp Math"
    case Spirograph = "Spirograph"
    case SpriteKit = "Sprite Kit"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .BackgroundBlob: BackgroundAnimationBlurProject()
        case .FallingSnow: FallingSnowProject()
        case .GlowingParticles: GlowingParticlesProject()
        case .LavaLamp: LavaLampProject()
        case .LavaLampMath: LavaLampMathProject()
        case .Spirograph: SpirographView()
        case .SpriteKit: SpriteKitProject()
        }
    }
}

enum ControllingWorkProjects: String, CaseIterable {
    case DelayingWork = "Delaying Work"
    case SkippingWork = "Skipping Work"
    case WatchingForChanges = "Watching For Changes"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .DelayingWork: DelayingWorkProject()
        case .SkippingWork: SkippingWorkProject()
        case .WatchingForChanges: WatchingForChangesProject()
        }
    }
}
