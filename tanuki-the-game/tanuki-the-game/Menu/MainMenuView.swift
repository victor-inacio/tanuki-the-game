//
//  MainMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 25/03/24.
//

import SwiftUI

struct MainMenuView: View {
    
    @Binding var currentView: CoordinatorViewType
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.7)) {
                        self.currentView = .game
                    }
                }) {
                    VStack{
                        Spacer()
                        Image(.appLogo)
                        Spacer()
                        Text("tap to play")
                            .foregroundStyle(.white)
                            .font(.custom("DarumaDropOne-Regular", size: 40))
                            .bold()
                        Spacer()
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(hex: "457847"))
//            .background(Gradient(colors: [.white, .white, .green]).opacity(1))
            //just trying to simulate having an image in the background
        }
    }
}

//#Preview {
//    MainMenuView(currentView:).environment(Coordinator())
//}
