//
//  SkippingWorkProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 03.06.23.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
    @State private var hasLoaded = false
    var perform: () -> Void
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard hasLoaded == false else { return }
            hasLoaded = true
            perform()
        }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(perform: perform))
    }
}

extension View {
    func watchOS<Content: View>(_ modifier: @escaping (Self) -> Content) -> some View {
        #if os(watchOS)
        modifier(self)
        #else
        self
        #endif
    }
}

struct SkippingWorkExampleView: View {
    let number: Int
    
    var body: some View {
        Text("View: \(number)")
            .onFirstAppear {
                print("View \(number) appeared")
            }
            .watchOS {
                $0.padding(0)
            }
    }
}

// Note: using @State over let will also cause less re-creation of variables!
struct SkippingWorkProject: View {
    var body: some View {
        TabView {
            ForEach(1..<6) { i in
                SkippingWorkExampleView(number: i)
                    .tabItem {
                        Label(String(i), systemImage: "\(i).circle")
                    }
            }
        }
    }
}

struct SkippingWorkProject_Previews: PreviewProvider {
    static var previews: some View {
        SkippingWorkProject()
    }
}
