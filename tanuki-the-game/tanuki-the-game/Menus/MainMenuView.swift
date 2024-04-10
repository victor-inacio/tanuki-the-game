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
            ZStack{
                Image(.menuBG)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack {
                    Button(action: {
                        withAnimation(.easeOut(duration: 1.5)) {
                            self.currentView = .game
                        }
                    }) {
                        VStack{
                            Spacer()
                            Image(.appLogo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 528, height: 118)
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
                //            .background(Gradient(colors: [.white, .white, .green]).opacity(1))
                //just trying to simulate having an image in the background
            }
        }
    }
}

//#Preview {
//    MainMenuView(currentView:).environment(Coordinator())
//}
