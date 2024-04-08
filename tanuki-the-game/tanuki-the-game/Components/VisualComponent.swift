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
        print("test")
        super.init()
        
    }
    
    
    func katanaModel(){
//        "tanuki.scn", nameOfChild: "Armature"))
        model.removeFromParentNode()
        let scene = SCNScene(named: "tanuki.scn")
        model = scene!.rootNode.childNode( withName: "Armature" , recursively: true)!
//        model.scale = .init(x: 0.2, y: 0.2, z: 0.2)
        rotationNode.addChildNode(model)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
