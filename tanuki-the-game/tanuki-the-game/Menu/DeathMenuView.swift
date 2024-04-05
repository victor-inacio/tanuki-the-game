//
//  DeathMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//

import SwiftUI

struct DeathMenuView: View {
    
    @Binding var currentView: CoordinatorViewType
    
    var body: some View {
        Color.black
            .ignoresSafeArea(.all)
            .overlay(
                VStack{
                    Text("GAME OVER")
                        .font(.custom("DarumaDropOne-Regular", size: 50))
                        .foregroundStyle(.white)
                        .bold()
                    
                    Button(action: {
                        self.currentView = .mainMenuView
                        
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .frame(width: 190, height: 60)
                            RoundedRectangle(cornerRadius: 17)
                                .foregroundStyle(.black)
                                .frame(width: 180, height: 50)
                            Text("Back to Menu")
                                .foregroundStyle(.white)
                                .font(.custom("DarumaDropOne-Regular", size: 25))
                                .bold()
                        }
                    }
                    .padding()
                }
        )
    }
}

//#Preview {
//    DeathMenuView().environment(Coordinator())
//}
