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
    var spawner: SpawnerEntity!
    
    
    var firstFrame = true
    
    var lastTime: TimeInterval = 0.0
    
    init(scnView: SCNView) {
        super.init()
        
        spawner = SpawnerEntity(isVisible: true, scene: self)
        
        scnView.delegate = self
        self.physicsWorld.contactDelegate = self
        
        GameManager.scene = self
        overlay = Overlay(size: scnView.bounds.size)
        overlay.controllerDelegate = self
        scnView.overlaySKScene = overlay
        
        self.physicsWorld.gravity = SCNVector3(0, -9.8, 0)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        rootNode.addChildNode(ambientLightNode)
        
        setupCamera()
        setupPlayer()
        setupEnemy()
        setupScenario()
        setupWaveStateMachine()
        setupSpawners()
        
        
    }
    
    func onButtonUp() {
        
    }
    
    func onButtonDown() {
        if player.stateMachine.currentState is AttackingState == false{
            player.stateMachine.enter(AttackingState.self)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.sceneRenderer = renderer
        
        Time.deltaTime = time - lastTime
        lastTime = time
        
        
        if (firstFrame) {
            firstFrame = false
            
            return
        }
        
        camera.followTarget(target: player.node.simdPosition, offset: simd_float3(1, 2, 0))
        
        player.update(deltaTime: Time.deltaTime)
        
        for enemy in GameManager.enemies {
            enemy.update(deltaTime: Time.deltaTime)
        }
        
        spawner.update()
        self.waveStateMachine?.update(deltaTime: time)
        
        player.update(deltaTime: Time.deltaTime)
//        enemy.update(deltaTime: Time.deltaTime)
    }
    
    func setupEnemy() {
        
        enemy = EnemyEntity()
        enemy.node.simdPosition = .init(x: 0, y: 2, z: 8)
        enemy.agentComponent.position = enemy.node.simdPosition
    
        rootNode.addChildNode(enemy.node)
    }
    
    func setupPlayer(){
        
        player = PlayerEntity(physicsWorld: self.physicsWorld)
        rootNode.addChildNode(player.node)
        player.node.position = SCNVector3(x: -1, y: 0, z: 6)
        
        
        GameManager.player = player
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
        GameManager.camera = camera
        rootNode.addChildNode(camera.node)
    }
    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        
    }
    
    func setupWaveStateMachine(){
        self.waveStateMachine = GKStateMachine(states: [
            WaveIdle(waveManager: waveManager),
            WaveHoard1(waveManager: waveManager),
            WaveHoard2(waveManager: waveManager),
            WaveHoard3(waveManager: waveManager)
        ])
        self.waveStateMachine?.enter(WaveHoard1.self)
    }
    
    func setupSpawners(){
        spawner.scene = self
        spawner.waveManager = waveManager
        spawner.spawnPoint.position = SCNVector3(0, -0.5, 7)
        spawner.scene.rootNode.addChildNode(spawner.spawnPoint)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact){
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        
        let bitmaskA = nodeA.physicsBody!.categoryBitMask
        let bitmaskB = nodeB.physicsBody!.categoryBitMask
        let collision = bitmaskA | bitmaskB
        
        switch collision {
        case Bitmask.character.rawValue | Bitmask.enemy.rawValue:
//            print("character -> enemy")
            return
            
        case Bitmask.playerWeapon.rawValue | Bitmask.enemy.rawValue | Bitmask.character.rawValue:
//            print("sword -> enemy")
            let nodesInvolved = [nodeA, nodeB]
            
            for node in nodesInvolved {
                if node.name == "collider"{
                    player.attackComponent.handleAttackContact(target: node)
            
                }
            }
            
        default:
            break
        }
    }
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

