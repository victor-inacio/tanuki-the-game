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
    var scenario: ScenarioEntity!
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
        
   
        
        setupCamera()
   
      
        
        self.physicsWorld.gravity = SCNVector3(0, -9.8, 0)
        
      
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        rootNode.addChildNode(ambientLightNode)
        
        setupPlayer()
        setupScenario()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        deltaTime = time - lastTime
        lastTime = time
    }
    
    func setupPlayer(){
        rootNode.addChildNode(player.node)
    }
    
    func setupScenario(){
        scenario = ScenarioEntity()
        scenario.node.eulerAngles.x = -.pi / 2
        scenario.node.position = SCNVector3(x: 0, y: -1, z: 0)
 
        
        rootNode.addChildNode(scenario.node)
    }
    
    func setupCamera(){
        camera = SCNCamera()
        
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        rootNode.addChildNode(cameraNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

