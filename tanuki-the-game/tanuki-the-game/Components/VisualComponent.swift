//
//  VisualComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit


class VisualComponent: GKComponent {
    var containerNode = SCNNode()
    var rotationNode = SCNNode()
    var model: SCNNode!
    
    
    init(modelFile: String, nameOfChild: String){
        
        let scene = SCNScene(named: modelFile)!
        model = scene.rootNode.childNode( withName: nameOfChild , recursively: true)
        
        rotationNode.addChildNode(model)
        containerNode.addChildNode(rotationNode)
        
        super.init()
    }
    
    
    func katanaModel(){
      
        let scene = SCNScene(named: "katana.scn")!
        model = scene.rootNode.childNode( withName: "Cube" , recursively: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
