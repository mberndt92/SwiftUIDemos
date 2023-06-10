//
//  WatchingForChangesProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 03.06.23.
//

import SwiftUI

class AutorefreshingObject: ObservableObject {
    var timer: Timer?
    
    init() {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//            self.objectWillChange.send()
//        }
    }
}

extension View {
    func debugPrint(_ value: @autoclosure () -> Any) -> some View {
        #if DEBUG
        print(value())
        #endif
        
        return self
    }
    
    func debugExecute(_ function: () -> Void) -> some View {
        #if DEBUG
        function()
        #endif
        
        return self
    }
    
    func debugExecute(_ function: (Self) -> Void) -> some View {
        #if DEBUG
        function(self)
        #endif
        
        return self
    }
    
    func assert(
        _ condition: @autoclosure () -> Bool,
        _ message: @autoclosure () -> String = String(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> some View {
        Swift.assert(condition(), message(), file: file, line: line)
        return self
    }
}

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}

struct WatchingForChangesProject: View {
    @StateObject private var viewModel = AutorefreshingObject()
    
    var debugForChanges = false
    
    @State private var counter = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if debugForChanges {
            let _ = Self._printChanges()
            Self._printChanges()
        }
        
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { _ in
                counter += 1
            }
            .assert(counter < 50, "Timer exceeded")
            .background(.random)
    }
}

struct WatchingForChangesProject_Previews: PreviewProvider {
    static var previews: some View {
        WatchingForChangesProject()
    }
}
