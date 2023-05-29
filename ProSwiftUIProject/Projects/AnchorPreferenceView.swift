//
//  AnchorPreferenceView.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 26.05.23.
//

import SwiftUI

struct Category: Identifiable, Equatable {
    let id: String
    let symbol: String
}

struct CategoryPreference: Equatable {
    let category: Category
    let anchor: Anchor<CGRect>
}

struct CategoryPreferenceKey: PreferenceKey {
    static let defaultValue = [CategoryPreference]()
    
    static func reduce(value: inout [CategoryPreference], nextValue: () -> [CategoryPreference]) {
        value.append(contentsOf: nextValue())
    }
}

struct CategoryButton: View {
    var category: Category
    @Binding var selection: Category?
    
    var body: some View {
        Button {
            withAnimation {
                selection = category
            }
        } label: {
            VStack {
                Image(systemName: category.symbol)
                Text(category.id)
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(category.id)
        .anchorPreference(key: CategoryPreferenceKey.self, value: .bounds) { anchor in
            [CategoryPreference(category: category, anchor: anchor)]
        }
    }
}

struct AnchorPreferenceView: View {
    
    @State private var selectedCategory: Category?
    
    let categories = [
        Category(id: "Artic", symbol: "snowflake"),
        Category(id: "Beach", symbol: "beach.umbrella"),
        Category(id: "Shared Homes", symbol: "house")
    ]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    CategoryButton(
                        category: category,
                        selection: $selectedCategory
                    )
                }
            }
            
            List(categories) { category in
                HStack {
                    Button(category.id) {
                        withAnimation {
                            selectedCategory = category
                        }
                    }
                    
                    if selectedCategory == category {
                        Spacer()
                        
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            if let selectedCategory {
                Text("Selected: \(selectedCategory.id)")
            }
            
        }
        .overlayPreferenceValue(CategoryPreferenceKey.self) { preferences in
            GeometryReader { proxy in
                if let selected = preferences.first(where: { $0.category == selectedCategory }) {
                    let frame = proxy[selected.anchor]
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: frame.width, height: 2)
                        .position(x: frame.midX, y: frame.maxY)
                }
            }
        }
    }
}

struct AnchorPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPreferenceView()
    }
}
