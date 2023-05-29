//
//  PreferenceKeyView.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 26.05.23.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue = 0.0
    
    static func reduce(value: inout Double, nextValue: () -> Double) {
//        value = nextValue() // -> last only
        value += nextValue() // -> sum them all up
//        NOTHING // -> first only
    }
}

struct SizingView: View {
    @State private var width = 50.0
    
    var body: some View {
        Color.red
            .frame(width: width, height: 100)
            .onTapGesture {
                width = Double.random(in: 50...160)
            }
            .preference(key: WidthPreferenceKey.self, value: width)
    }
    
}

struct PreferenceKeyView: View {
    
    @State private var width = 0.0
    
    var body: some View {
        NavigationStack {
            VStack {
                SizingView()
                SizingView()
                SizingView()
                
                Text("100%")
                    .frame(width: width)
                    .background(.red)
                
                Text("150%")
                    .frame(width: width * 1.5)
                    .background(.green)
                
                Text("200%")
                    .frame(width: width * 2)
                    .background(.orange)
                
            }
            .onPreferenceChange(WidthPreferenceKey.self) {
                width = $0
            }
            .navigationTitle("Width: \(width)")
        }
    }
}

struct PreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyView()
    }
}
