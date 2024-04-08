//
//  CoordinatorView.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//

import SwiftUI

enum CoordinatorViewType {
    case mainMenuView, game, deathMenuView, drawingView
}

struct CoordinatorView: View {
    @State private var currentView: CoordinatorViewType = .mainMenuView
    
    var body: some View {
        VStack {
            displayView()
        }
    }
    
    @ViewBuilder
    func displayView() -> some View {
        switch currentView {
        case .mainMenuView:
            MainMenuView(currentView: $currentView)
                .ignoresSafeArea()
        case .deathMenuView:
            DeathMenuView(currentView: $currentView)
                .ignoresSafeArea()
        case .drawingView:
            DrawingView(currentView: $currentView, viewModel: DrawingViewModel(), presentationViewModel: PresentationViewModel())
                .ignoresSafeArea()
        case .game :
            GameViewControllerWrapper()
                .ignoresSafeArea()
        }
    }
}
