//
//  OverrideEnvironment.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 25.05.23.
//

import SwiftUI

/**
 How to "override" fonts in child view but not purely.
 We just want to apply something on TOP of the font, not replace it hardcoded by e.g. largeTitle or headline.
 */

struct WelcomeView: View {
    var body: some View {
        VStack {
            // Goal: How to override this font!? :)
            Image(systemName: "sun.max")
                .transformEnvironment(\.font) { font in
                    font = font?.weight(.black)
                }
            
            Text("Welcome")
        }
    }
}

struct OverrideEnvironment: View {
    var body: some View {
        WelcomeView()
            .font(.headline)
    }
}

struct OverrideEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        OverrideEnvironment()
    }
}
