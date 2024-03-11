//
//  MainScene.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import SceneKit

class MainScene: SCNScene {
    
    var player = PlayerEntity()
    
    override init() {
        super.init()
        
       rootNode.addChildNode(player.node)
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        rootNode.addChildNode(cameraNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        rootNode.addChildNode(ambientLightNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

