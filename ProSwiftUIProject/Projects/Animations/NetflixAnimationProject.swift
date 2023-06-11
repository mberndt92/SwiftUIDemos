//
//  NetflixAnimationProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 10.06.23.
//

import SwiftUI

struct Account: Identifiable {
    var id = UUID()
    let name: String
    let icon: String
    let background: Color
}

extension Account {
    static var examples: [Account] = [
        Account(name: "Brisa", icon: "figure.wave", background: .cyan),
        Account(name: "Hermana", icon: "figure.walk", background: .green),
        Account(name: "Doníris", icon: "figure.fall", background: .orange),
        Account(name: "Lunchio", icon: "figure.run", background: .mint),
        Account(name: "Zévitu", icon: "figure.roll", background: .yellow)
    ]
}

extension Account: Equatable {
    static func ==(lhs: Account, rhs: Account) -> Bool {
        return lhs.name == rhs.name
    }
}

struct NetflixAnimationProject: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 90))
    ]
    
    let singleColumn = [
        GridItem(.fixed(90))
    ]
    
    var accounts: [Account] = Account.examples
    
    @State private var selectedProfile: Account? = nil
    @State private var frameWidth = 80.0
    
    @State private var xOffset = 0.0
    @State private var yOffset = 0.0
    
    @State private var scale = 1.0
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center) {
                LazyVGrid(columns: selectedProfile == nil ? columns : singleColumn, alignment: .center, spacing: 20) {
                    ForEach(accounts, id: \.name) { account in
                        if selectedProfile == nil || selectedProfile == account {
                            ProfileIconView(frameWidth: frameWidth, account: account)
                            .offset(x: xOffset, y: yOffset)
                            .scaleEffect(scale)
                            .onTapGesture {
                                withAnimation {
                                    if selectedProfile == nil {
                                        selectedProfile = account
                                        frameWidth = 120
                                    } else {
                                        selectedProfile = nil
                                        frameWidth = 80
                                        scale = 1.0
                                    }
                                }
                                
                            }
                            .transaction {
                                $0.addAnimationCompletion {
                                    withAnimation(.bouncy(duration: 1).delay(0.75)) {
                                        scale = 0.3 // this conflicts with the offset, leading to magic numbers being added
                                        xOffset = proxy.frame(in: .local).midX * 2.2 // magic number
                                        yOffset = -proxy.frame(in: .local).maxY * 1.6 // magic number
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
            }
        }
    }
}

#Preview {
    NetflixAnimationProject()
}
