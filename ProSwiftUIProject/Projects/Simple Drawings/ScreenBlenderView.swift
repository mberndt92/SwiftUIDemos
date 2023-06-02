//
//  ScreenBlenderView.swift
//  Drawing
//
//  Created by Maximilian Berndt on 2023/03/28.
//

import SwiftUI

struct ScreenBlenderCircles: View {
    
    @State private var amount = 0.5
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.red)
                .frame(width: 200 * amount)
                .offset(x: -50, y: -80)
                .blendMode(.screen)
            Circle()
                .fill(.green)
                .frame(width: 200 * amount)
                .offset(x: 50, y: -80)
                .blendMode(.screen)
            Circle()
                .fill(.blue)
                .frame(width: 200 * amount)
                .blendMode(.screen)
        }
        .frame(width: 300, height: 300)
        Slider(value: $amount)
            .padding()
    }
}

struct ScreenBlenderView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ScreenBlenderCircles()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        .navigationTitle("Screen Blender Circles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScreenBlenderView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenBlenderView()
    }
}
