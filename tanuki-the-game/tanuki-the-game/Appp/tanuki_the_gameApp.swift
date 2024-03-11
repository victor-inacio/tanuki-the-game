//
//  tanuki_the_gameApp.swift
//  tanuki-the-game
//
//  Created by Victor Soares on 08/03/24.
//

import SwiftUI

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        
        return GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context){
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            GameViewControllerWrapper()
                .ignoresSafeArea()
        }
    }
}
