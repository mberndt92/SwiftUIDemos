//
//  ContentView.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 22.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var id = UUID()
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Sports Circle Transition") {
                    SportsCircleTransitions()
                }
                
                NavigationLink("Animating zIndex") {
                    AnimatingTheUnanimatable()
                }
                
                NavigationLink("Animating Font") {
                    AnimatingFont()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
