//
//  ContentView.swift
//  tanuki-the-game
//
//  Created by Victor Soares on 08/03/24.
//

import SwiftUI
import SpriteKit
import SceneKit

struct ContentView: View {
    var body: some View {
            Representable()
    }
}

struct Representable: UIViewRepresentable {
    
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
   
    
   
    var scene: SCNScene
    var view: SCNView
    
    init() {
        let scene = MainScene(scnView: <#T##SCNView#>)
        
        scene.scaleMode = .aspectFill
        
        let joystick = Joystick()
        
        joystick.position = .init(x: scene.size.width / 2, y: scene.size.height / 2)
        
        scene.addChild(joystick)
        let view = SKView()
        
        self.scene = scene
        self.view = view
        
        view.presentScene(scene)
    }
    

    
    func makeCoordinator() -> RepresentableCoordinator {
        return RepresentableCoordinator()
    }
    
    func makeUIView(context: Context) -> some SKView {
        return view
    }

}

class RepresentableCoordinator{
    
    
}

#Preview {
    ContentView()
}
