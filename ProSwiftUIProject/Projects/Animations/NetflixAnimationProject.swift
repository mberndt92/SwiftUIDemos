//
//  NetflixAnimationProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 10.06.23.
//

import SwiftUI

struct Account {
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
                            VStack {
                                Image(systemName: account.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 50)
                                Text(account.name)
                                    .font(.headline)
                            }
                            .frame(width: frameWidth, height: frameWidth)
                            .transaction {
                                $0.addAnimationCompletion {
                                    withAnimation(.easeIn(duration: 0.5).delay(0.75)) {
                                        xOffset = proxy.frame(in: .local).midX * 0.5
                                        yOffset = -proxy.size.height
                                        scale = 0.3
                                        // Need to change this to keyframes to also scale it down on the go
                                    }
                                }
                            }
                            .padding()
                            .background(account.background)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
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
                        }
                    }
                }
                .padding(.horizontal)
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                
            }
        }
        
        // We have some profiles to begin with
        // On selection, the selected one becomes the only visible one, centered & enlarged
        // It then "swooshes" up to the top right and outside of the view
        // Kind of attempted to look natural then the toolbar icon appears with the curved backwards move towards its final position.
    }
}

#Preview {
    NetflixAnimationProject()
}