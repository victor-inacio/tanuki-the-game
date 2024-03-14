//
//  MainScene.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import SceneKit

class MainScene: SCNScene, SCNSceneRendererDelegate, JoystickDelegate {
   
    var player = PlayerEntity()
    var scenario: ScenarioEntity!
    var overlay: Overlay!
    var camera: Camera!
    
    var firstFrame = true
    
    var lastTime: TimeInterval = 0.0
    
    var joystickDir: simd_float2 = simd_float2(0, 0)
    
    init(scnView: SCNView) {
        super.init()
        scnView.delegate = self
        
        overlay = Overlay(size: scnView.bounds.size)
        overlay.controllerDelegate = self
        scnView.overlaySKScene = overlay
    
       

        self.physicsWorld.gravity = SCNVector3(0, -9.8, 0)

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        rootNode.addChildNode(ambientLightNode)
        
        setupPlayer()
        setupScenario()
        setupCamera()
        
    }
    
    func onJoystickChange(_ joystickData: JoystickData) {
        joystickDir = joystickData.direction
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Time.deltaTime = time - lastTime
        lastTime = time
        
        
        if (firstFrame) {
            firstFrame = false
            
            return
        }
        
        player.moveToDir(dir: joystickDir)
        camera.followTarget(target: player.node.simdPosition, offset: simd_float3(5, 5, 0))
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
        camera = Camera()
        
        
        rootNode.addChildNode(camera.node)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

