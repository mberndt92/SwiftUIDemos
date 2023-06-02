//
//  BlurView.swift
//  Drawing
//
//  Created by Maximilian Berndt on 2023/03/28.
//

import SwiftUI

struct BlurView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Image("mberndt")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .navigationTitle("Blur")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView()
    }
}
