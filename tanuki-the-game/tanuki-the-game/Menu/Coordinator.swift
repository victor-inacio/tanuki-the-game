//
//  Coordinator.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//
//
//import Foundation
//import SwiftUI
//
//enum Page: String, Identifiable {
//    case mainMenu, deathMenu, game, drawing
//    
//    var id: String {
//        self.rawValue
//    }
//}
//
//enum FullScreenCover: String, Identifiable {
//    case mainMenu, deathMenu, game, drawing
//    
//    var id: String {
//        self.rawValue
//    }
//}
//
//@Observable class Coordinator {
//    
//    var path = NavigationPath()
//    var fullScreenCover: FullScreenCover?
//    
//    func push(_ page: Page) {
//        path.append(page)
//    }
//    
//    func present(fullScreenCover: FullScreenCover) {
//        self.fullScreenCover = fullScreenCover
//    }
//    
//    func pop() {
//        path.removeLast()
//    }
//    
//    func popToRoot() {
//        path.removeLast(path.count)
//    }
//    
//    func dismissFullScreenCover() {
//        self.fullScreenCover = nil
//    }
//    
//    @ViewBuilder
//    func build(page: Page) -> some View {
//        switch page {
//        case .mainMenu:
//            MainMenuView()
//        case .deathMenu:
//            DeathMenuView()
//        case .game:
//            GameViewControllerWrapper()
//        case .drawing:
//            DrawingView(viewModel: DrawingViewModel(), presentationViewModel: PresentationViewModel())
//        }
//    }
//    
//    @ViewBuilder
//    func build(fullScreenCover: FullScreenCover) -> some View {
//        switch fullScreenCover {
//        case .mainMenu:
//            MainMenuView()
//                .ignoresSafeArea()
//        case .deathMenu:
//            DeathMenuView()
//                .ignoresSafeArea()
//        case .game:
//            GameViewControllerWrapper()
//                .ignoresSafeArea()
//        case .drawing:
//            DrawingView(viewModel: DrawingViewModel(), presentationViewModel: PresentationViewModel())
//                .ignoresSafeArea()
//        }
//    }
//    
//}
