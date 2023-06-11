//
//  NetflixAnimationProjectKeyFrames.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 11.06.23.
//

import SwiftUI

struct ProfileIconView: View {
    let frameWidth: Double
    var cornerRadius = 25.0
    let account: Account
    var showText = true
    
    var body: some View {
        VStack {
            Image(systemName: account.icon)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 50)
            if showText {
                Text(account.name)
                    .font(.headline)
            }
        }
        .frame(width: frameWidth, height: frameWidth)
        .padding()
        .background(account.background)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct NetflixAnimationProjectKeyFrames: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 90))
    ]
    
    let singleColumn = [
        GridItem(.fixed(90))
    ]
    
    var accounts: [Account] = Account.examples
    
    @State private var startKeyframeAnimation = false
    @State private var selectedProfile: Account? = nil
    @State private var frameWidth = 80.0
    @State private var toolbarOpacity = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center) {
                LazyVGrid(columns: selectedProfile == nil ? columns : singleColumn, alignment: .center, spacing: 20) {
                    ForEach(accounts) { account in
                        if selectedProfile == nil || selectedProfile == account {
                            ProfileIconView(frameWidth: frameWidth, account: account)
                                .onTapGesture {
                                    withAnimation {
                                        if selectedProfile == nil {
                                            selectedProfile = account
                                            frameWidth = 120
                                        } else {
                                            selectedProfile = nil
                                            frameWidth = 80
                                            startKeyframeAnimation.toggle()
                                        }
                                    }
                                    startKeyframeAnimation.toggle()
                                }
                                .keyframeAnimator(initialValue: KeyFrame(), trigger: startKeyframeAnimation) { view, frame in
                                    view
                                        .scaleEffect(isSelected(account: account) ? frame.scale : 1.0)
                                        .offset(x: isSelected(account: account) ? frame.offsetX : 0, y: isSelected(account: account) ? frame.offsetY : 0)
                                } keyframes: { frame in
                                    KeyframeTrack(\.scale) {
                                        SpringKeyframe(1, duration: 1)
                                        CubicKeyframe(0.9, duration: 0.15)
                                        CubicKeyframe(0.3, duration: 0.4)
                                        SpringKeyframe(0.4, duration: 0.15)
                                        SpringKeyframe(0.3, duration: 0.15)
                                    }
                                    
                                    KeyframeTrack(\.offsetX) {
                                        SpringKeyframe(0, duration: 1)
                                        CubicKeyframe(0, duration: 0.15) // do nothing
                                        SpringKeyframe(proxy.frame(in: .local).midX * 0.75, duration: 0.4)
                                    }
                                    
                                    KeyframeTrack(\.offsetY) {
                                        SpringKeyframe(0, duration: 1)
                                        CubicKeyframe(10, duration: 0.15)
                                        SpringKeyframe(-10.0 - proxy.frame(in: .local).midY * 0.9, duration: 0.5)
                                    }
                                }
                            // This idea doesn't animate well =( seems veeeery buggy
                            /*
                                .toolbar {
                                    ToolbarItem {
                                        if selectedProfile != nil {
                                            ProfileIconView(frameWidth: 80 * 0.3, cornerRadius: 10, account: selectedProfile!, showText: false)
                                                .opacity(toolbarOpacity)
                                                .onTapGesture(perform: {
                                                    withAnimation {
                                                        startKeyframeAnimation.toggle()
                                                    }
                                                })
                                                .keyframeAnimator(initialValue: ToolbarKeyFrame(), trigger: startKeyframeAnimation) { view, frame in
                                                    view
                                                        .scaleEffect(frame.scaleEffect)
                                                } keyframes: { frame in
                                                    KeyframeTrack(\.scaleEffect) {
                                                        SpringKeyframe(1.0, duration: 0.1)
                                                    }
                                                }
                                        }
                                    }
                                }
                             */
                        }
                    }
                }
                .padding(.horizontal)
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
            }
        }
    }
    
    private func isSelected(account: Account) -> Bool {
        guard let selectedProfile else { return false }
        return account == selectedProfile
    }
    
    struct KeyFrame {
        var scale = 1.0
        var offsetX = 0.0
        var offsetY = 0.0
    }
    
    struct ToolbarKeyFrame {
        var scaleEffect = 0.1
    }
}

#Preview {
    NavigationStack {
        NetflixAnimationProjectKeyFrames()
    }
}
