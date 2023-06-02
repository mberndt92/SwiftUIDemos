//
//  ContentView.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 22.05.23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section("Animations") {
                    ForEach(AnimationProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                        }
                    }
                }
                
                Section("Simple Drawings") {
                    ForEach(SimpleDrawingProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                        }
                    }
                }
                
                Section("Global Settings") {
                    ForEach(GlobalSettingsProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                        }
                    }
                }
                
                Section("Custom Layouts") {
                    ForEach(CustomLayoutProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                        }
                    }
                }
                
                Section("Drawing & Magic") {
                    ForEach(DrawingMagicProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Swift UI Projects")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
