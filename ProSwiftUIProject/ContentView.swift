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
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                
                Section("Simple Drawings") {
                    ForEach(SimpleDrawingProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                
                Section("Global Settings") {
                    ForEach(GlobalSettingsProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                
                Section("Custom Layouts") {
                    ForEach(CustomLayoutProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                
                Section("Drawing & Magic") {
                    ForEach(DrawingMagicProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                
                Section("Controlling Work") {
                    ForEach(ControllingWorkProjects.allCases, id: \.self) { view in
                        NavigationLink(view.rawValue) {
                            view.view()
                                .navigationTitle(view.rawValue)
                                .navigationBarTitleDisplayMode(.inline)
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
