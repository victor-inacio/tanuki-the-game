//
//  MainScene.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import SceneKit

class MainScene: SCNScene, SCNSceneRendererDelegate {
    var player = PlayerEntity()
    var overlay: Overlay!
    var camera: SCNCamera!
    var cameraNode: SCNNode!
    
    var lastTime: TimeInterval = 0.0
    var deltaTime: TimeInterval = 0.0
    
    init(scnView: SCNView) {
        super.init()
        scnView.delegate = self
        
        overlay = Overlay(size: scnView.bounds.size)
        
        scnView.overlaySKScene = overlay
        
        rootNode.addChildNode(player.node)
        
        camera = SCNCamera()
        
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        

        
        rootNode.addChildNode(cameraNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        rootNode.addChildNode(ambientLightNode)
        
        
        let plane = SCNPlane(width: 10, height: 10)
        let planeNode = SCNNode(geometry: plane)
        planeNode.look(at: cameraNode.position)
        print(rootNode.childNodes)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {


    
        deltaTime = time - lastTime
        lastTime = time
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

