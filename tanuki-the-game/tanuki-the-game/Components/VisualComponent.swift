//
//  VisualComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit


class VisualComponent: GKComponent {
    var model: SCNNode!
    
     init(modelFile: String, nameOfChild: String){

        let scene = SCNScene(named: modelFile)!
         model = scene.rootNode.childNode( withName: nameOfChild , recursively: true)
        
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
