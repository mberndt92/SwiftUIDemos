//
//  DelayingWorkProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 03.06.23.
//

import Combine
import SwiftUI

class Debouncer<T>: ObservableObject {
    @Published var input: T
    @Published var output: T
    
    private var debounce: AnyCancellable?
    
    init(initialValue: T, delay: Double = 1) {
        self.input = initialValue
        self.output = initialValue
        
        debounce = $input
            .debounce(for: .seconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.output = $0
            }
    }
}

class RefreshTaskViewModel: ObservableObject {
    private var refreshTask: Task<Void, Error>?
    var workCounter = 0
    
    func doWorkNow() {
        workCounter += 1
        print("Work done: \(workCounter)")
    }
    
    func scheduleWork() {
        refreshTask?.cancel()
        
        refreshTask = Task {
            try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
            doWorkNow()
        }
    }
}

// Alternative without Combine
struct DelayingWorkProject: View {
    
    @StateObject private var text = Debouncer(initialValue: "", delay: 0.5)
    @StateObject private var slider = Debouncer(initialValue: 0.0, delay: 0.1)
    
    var body: some View {
        VStack {
            TextField("Search for something", text: $text.input)
                .textFieldStyle(.roundedBorder)
            
            Text(text.output)
            
            Spacer().frame(height: 50)
            
            Slider(value: $slider.input, in: 0...100)
            Text(slider.output.formatted())
        }
        .padding()
    }
}

struct DelayingWorkProject_Previews: PreviewProvider {
    static var previews: some View {
        DelayingWorkProject()
    }
}
