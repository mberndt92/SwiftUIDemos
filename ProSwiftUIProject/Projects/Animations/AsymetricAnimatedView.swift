//
//  AsymetricAnimatedView.swift
//  Animations
//
//  Created by Maximilian Berndt on 2023/03/17.
//

import SwiftUI

struct AsymetricAnimatedView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
//                    .transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        .navigationTitle("Asymetric Animated View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AsymetricAnimatedView_Previews: PreviewProvider {
    static var previews: some View {
        AsymetricAnimatedView()
    }
}
