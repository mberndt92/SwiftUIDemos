//
//  RequiredText.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 25.05.23.
//

import SwiftUI

struct FormElementRequiredKey: EnvironmentKey {
    static var defaultValue = false
}

extension EnvironmentValues {
    var required: Bool {
        get { self[FormElementRequiredKey.self] }
        set { self[FormElementRequiredKey.self] = newValue }
    }
}

struct RequirableTextField: View {
    @Environment(\.required) var required
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(title, text: $text)
            
            if required {
                Image(systemName: "asterisk")
                    .imageScale(.small)
                    .foregroundColor(.red)
            }
        }
    }
}

extension View {
    func required(_ makeRequired: Bool = true) -> some View {
        environment(\.required, makeRequired)
    }
}

struct RequiredText: View {
    @State private var firstName = ""
    @State private var lastName = ""
    
    @State private var isRequired = false
    
    var body: some View {
        Form {
            RequirableTextField(title: "First name", text: $firstName)
            RequirableTextField(title: "Last name", text: $lastName)
            
            Toggle("Is Required", isOn: $isRequired.animation())
        }
        .required(isRequired)
    }
}

struct RequiredText_Previews: PreviewProvider {
    static var previews: some View {
        RequiredText()
    }
}
