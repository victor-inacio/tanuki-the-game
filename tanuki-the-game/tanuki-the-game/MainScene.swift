//
//  MainScene.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import SceneKit
import GameplayKit

class MainScene: SCNScene, SCNSceneRendererDelegate, ButtonDelegate, SCNPhysicsContactDelegate {
    
    var player: PlayerEntity!
    var enemy: EnemyEntity!
    var scenario: ScenarioEntity!
    var overlay: Overlay!
    var camera: Camera!
    var waveManager = WaveManager()
    var waveStateMachine: GKStateMachine?
    var spawner = SpawnerEntity(isVisible: true)
    
    var firstFrame = true
    
    var lastTime: TimeInterval = 0.0
    
    init(scnView: SCNView) {
        super.init()
        
        scnView.delegate = self
        self.physicsWorld.contactDelegate = self
        
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
        setupWaveStateMachine()
        setupSpawners()
        
        // Create a red box geometry
        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 1.0, chamferRadius: 0.0)
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red
        boxGeometry.materials = [redMaterial]
        
        // Create a node with the box geometry
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(0, 2, 6) // Place the box in front of the camera
        
        // Add physics body to the node
        let boxPhysicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        boxPhysicsBody.categoryBitMask =  Bitmask.enemy.rawValue | Bitmask.character.rawValue
        boxPhysicsBody.contactTestBitMask = Bitmask.playerWeapon.rawValue
    
  
        boxNode.physicsBody = boxPhysicsBody
        
        // Add the node to the scene
        rootNode.addChildNode(boxNode)
        
        enemy = EnemyEntity()
        rootNode.addChildNode(enemy.enemyNode)
        enemy.enemyNode.position = SCNVector3(x: 0, y: -0.5, z: 7)
        
    }
    
    func onButtonUp() {
        
    }
    
    func onButtonDown() {
        player.attackComponent.attack()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Time.deltaTime = time - lastTime
        lastTime = time
        
        if (firstFrame) {
            firstFrame = false
            
            return
        }
        
        
        camera.followTarget(target: player.playerNode.simdPosition, offset: simd_float3(1, 1.5, 0))
        
        player.update(deltaTime: time)
        player.movementComponent.update(atTime: time, with: renderer)
        spawner.update()
        self.waveStateMachine?.update(deltaTime: time)
        
    }
    
    func setupPlayer(){
        
        player = PlayerEntity(physicsWorld: self.physicsWorld)
        rootNode.addChildNode(player.playerNode)
        player.playerNode.position = SCNVector3(x: 0, y: 0, z: 6)
    }
    
    func setupScenario(){
        
        let collisionsScene = SCNScene( named: "Art.scnassets/collision.scn" )
        collisionsScene!.rootNode.enumerateChildNodes { (_ child: SCNNode, _ _: UnsafeMutablePointer<ObjCBool>) in
            child.opacity = 1
            self.rootNode.addChildNode(child)
        }
    }
    
    func setupCamera(){
        camera = Camera()
        
        rootNode.addChildNode(camera.node)
    }
    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let bitmaskA = contact.nodeA.physicsBody!.categoryBitMask
        let bitmaskB = contact.nodeB.physicsBody!.categoryBitMask
        let collision = bitmaskA | bitmaskB
        
        switch collision {
        case Bitmask.character.rawValue | Bitmask.enemy.rawValue:
            print("Character collided with an enemy")
            
        case Bitmask.playerWeapon.rawValue | Bitmask.enemy.rawValue | Bitmask.character.rawValue:
            print("Player weapon collided with enemy")
            
        default:
            break
        }
    }
    
    func setupWaveStateMachine(){
        self.waveStateMachine = GKStateMachine(states: [
            WaveIdle(waveManager: waveManager),
            WaveHoard1(waveManager: waveManager),
            WaveHoard2(waveManager: waveManager),
            WaveHoard3(waveManager: waveManager)
        ])
        self.waveStateMachine?.enter(WaveHoard3.self)
    }
    
    func setupSpawners(){
        spawner.scene = self
        spawner.waveManager = waveManager
        spawner.spawnPoint.position = SCNVector3(0, -0.5, 7)
        spawner.scene.rootNode.addChildNode(spawner.spawnPoint)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact){
        
    }
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

