//
//  MainScene.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import SceneKit

class MainScene: SCNScene, SCNSceneRendererDelegate, JoystickDelegate, ButtonDelegate {
  
    var player: PlayerEntity!
    var scenario: ScenarioEntity!
    var overlay: Overlay!
    var camera: Camera!
    
    var firstFrame = true
    
    var lastTime: TimeInterval = 0.0
    
    var joystickDir: simd_float2 = simd_float2(0, -0)  {
        didSet {
            player.characterDirection = joystickDir
        }
    }
    
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
    
    func onButtonUp() {
        
    }
    
    func onButtonDown() {
            }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Time.deltaTime = time - lastTime
        lastTime = time
        
        if (firstFrame) {
            firstFrame = false
            
            return
        }
        
       
        camera.followTarget(target: player.playerNode.simdPosition, offset: simd_float3(1, 1, 0))
        
        player.update(deltaTime: time)
        player.movementComponent.update(atTime: time, with: renderer)

    }
    
    func setupPlayer(){
        player = PlayerEntity(physicsWorld: self.physicsWorld)
        rootNode.addChildNode(player.playerNode)


    }
    
    func setupScenario(){
        // load the collision mesh from another scene and merge into main scene
        let collisionsScene = SCNScene( named: "Art.scnassets/collision.scn" )
        collisionsScene!.rootNode.enumerateChildNodes { (_ child: SCNNode, _ _: UnsafeMutablePointer<ObjCBool>) in
            child.opacity = 0.0
            self.rootNode.addChildNode(child)
        }
    }
    
    func setupCamera(){
        camera = Camera()
        
        
        rootNode.addChildNode(camera.node)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

