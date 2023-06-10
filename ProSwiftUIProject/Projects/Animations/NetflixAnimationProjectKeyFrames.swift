//
//  NetflixAnimationProjectKeyFrames.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 11.06.23.
//

import SwiftUI

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
    
    @State private var xOffset = 0.0
    @State private var yOffset = 0.0
    
    @State private var scale = 1.0
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center) {
                LazyVGrid(columns: selectedProfile == nil ? columns : singleColumn, alignment: .center, spacing: 20) {
                    ForEach(accounts, id: \.name) { account in
                        if selectedProfile == nil || selectedProfile == account {
                            VStack {
                                Image(systemName: account.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 50)
                                Text(account.name)
                                    .font(.headline)
                            }
                            .frame(width: frameWidth, height: frameWidth)
                            .padding()
                            .background(account.background)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .offset(x: xOffset, y: yOffset)
                            .scaleEffect(scale)
                            .onTapGesture {
                                withAnimation {
                                    if selectedProfile == nil {
                                        selectedProfile = account
                                        frameWidth = 120
                                    } else {
                                        selectedProfile = nil
                                        frameWidth = 80
                                        scale = 1.0
                                    }
                                }
                                
                            }
                            .keyframeAnimator(initialValue: KeyFrame(), trigger: startKeyframeAnimation) { view, frame in
                                view
                                    .scaleEffect(frame.scale)
                                    .offset(x: frame.offsetX, y: frame.offsetY)
                            } keyframes: { frame in
                                KeyframeTrack(\.scale) {
                                    
                                }
                                
                                KeyframeTrack(\.offsetX) {
                                    
                                }
                                
                                KeyframeTrack(\.offsetY) {
                                    
                                }
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                
            }
        }
        
        // We have some profiles to begin with
        // On selection, the selected one becomes the only visible one, centered & enlarged
        // It then "swooshes" up to the top right and outside of the view
        // Kind of attempted to look natural then the toolbar icon appears with the curved backwards move towards its final position.
    }
    
    struct KeyFrame {
        var scale = 1.0
        var offsetX = 0.0
        var offsetY = 0.0
    }
}

#Preview {
    NetflixAnimationProjectKeyFrames()
}
