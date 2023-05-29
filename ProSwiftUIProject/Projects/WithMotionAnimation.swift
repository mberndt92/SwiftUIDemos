//
//  WithMotionAnimation.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 24.05.23.
//

import SwiftUI

// Option 1 - Free Function (will be overwritten by implicit animations)
func withMotionAnimation<Result>(
    _ animation: Animation? = .default,
    _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }

// Option 2 - View Modifier (better!)
struct MotionAnimationModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    
    let animation: Animation?
    let value: V
    
    func body(content: Content) -> some View {
        if accessibilityReduceMotion {
            content
        } else {
            content.animation(animation, value: value)
        }
    }
}

extension View {
    func motionAnimation<V: Equatable>(_ animation: Animation? = .default, value: V) -> some View {
        self.modifier(MotionAnimationModifier(animation: animation, value: value))
    }
}

// Option 3 - Transactions to have no animation
func withoutAnimation<Result>(_ body: () throws -> Result) rethrows -> Result {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    return try withTransaction(transaction, body)
}

// Option 4 - With High Priority Animation (overriding with different animation instead)
func withHighPriorityAnimation<Result>(
    _ animation: Animation? = .default,
    _ body: () throws -> Result) rethrows -> Result {
        var transaction = Transaction(animation: animation)
        transaction.disablesAnimations = true
        return try withTransaction(transaction, body)
    }

struct CircleGrid: View {
    var useRedFill = false
    
    var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 64))]) {
            ForEach(0..<30) { i in
                Circle()
                    .fill(useRedFill ? .red : .blue)
                    .frame(height: 64)
                    .transaction { transaction in
                        return transaction.animation = transaction.animation?.delay(Double(i) / 10)
                    }
            }
        }
    }
}

struct WithMotionAnimation: View {
    
//    @State private var scaleEffect = 1.0
    @State private var useRedFill = false
    
    var body: some View {
//        Button("Tap Me!") {
//            withHighPriorityAnimation(.linear) {
//                scaleEffect += 1
//            }
//        }
//        .scaleEffect(scaleEffect)
//        .animation(.default, value: scaleEffect)
        VStack {
            CircleGrid(useRedFill: useRedFill)
            Spacer()
            Button("Toggle") {
                withAnimation(.easeInOut) {
                    useRedFill.toggle()
                }
            }
        }
        
        
    }
}

struct WithMotionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WithMotionAnimation()
    }
}
