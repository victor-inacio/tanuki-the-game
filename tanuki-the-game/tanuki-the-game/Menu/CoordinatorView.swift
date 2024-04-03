//
//  CoordinatorView.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//

import SwiftUI

struct CoordinatorView: View {
  @State private var coordinator = Coordinator()

  var body: some View {
    NavigationStack(path: $coordinator.path) {
      coordinator.build(page: .mainMenu)
        .navigationDestination(for: Page.self) { page in
          coordinator.build(page: page)
                .transition(.opacity.animation(.easeIn)) // Or other transition types like .move, .opacity, etc.
            //WHY ISN'T THE ANIMATION WORKING OH MY GOOOOOOOOOOOOODDDD
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) {
          fullScreenCover in
            coordinator.build(fullScreenCover: fullScreenCover)
        }
    }
    .environment(coordinator)
  }
}

#Preview {
    CoordinatorView()
}
