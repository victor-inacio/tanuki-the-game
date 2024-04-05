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
                Text("Sakemori")
                    .font(.system(size: 60))
                    .foregroundStyle(.brown)
                    .bold()
                    .padding()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        self.currentView = .game
                    }
                    
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                            .frame(width: 130, height: 60)
                        RoundedRectangle(cornerRadius: 17)
                            .foregroundStyle(.brown)
                            .frame(width: 120, height: 50)
                        Text("Start")
                            .foregroundStyle(.white)
                            .font(.system(size:25))
                            .bold()
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
            .containerRelativeFrame([.horizontal, .vertical])
            .background(.white)
//            .background(Gradient(colors: [.white, .white, .green]).opacity(1))
            //just trying to simulate having an image in the background
        }
    }
}

//#Preview {
//    MainMenuView(currentView:).environment(Coordinator())
//}
