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
    var spawners: [SpawnerEntity]!
    
    
    
    var firstFrame = true
    
    var lastTime: TimeInterval = 0.0
    
    init(scnView: SCNView) {
        super.init()
        
        scnView.delegate = self
        self.physicsWorld.contactDelegate = self
        
        GameManager.scene = self
        overlay = Overlay(size: scnView.bounds.size)
        overlay.setup()
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
        setupScenario()
        setupWaveStateMachine()
        setupSpawners()
    }
    
    func onButtonUp(button: ButtonComponent) {
        
    }
    
    func onButtonDown(button: ButtonComponent) {
        if (button.name == "buttonA") {
            if player.stateMachine.currentState is AttackingState == false{
                player.stateMachine.enter(AttackingState.self)
            }
        }
        
        if (button.name == "buttonB") {
            if player.stateMachine?.currentState is TransformationState == false{
                player.stateMachine.enter(TransformationState.self)
            }
            
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
        
        
        
        player.update(deltaTime: Time.deltaTime)
        
        camera.followTarget(target: player.node.simdPosition, offset: simd_float3(1, 2, 0))
        
        for enemy in GameManager.enemies {
            enemy.update(deltaTime: Time.deltaTime)
        }
        
        for spawner in spawners {
            spawner.update()
        }
        
        self.waveStateMachine?.update(deltaTime: time)
        
        player.update(deltaTime: Time.deltaTime)
    }
    
    func setupEnemy() {
        
        enemy = EnemyEntity()
        enemy.node.simdPosition = .init(x: 0, y: 0, z: -1)
        enemy.agentComponent.position = enemy.node.simdPosition
    
        rootNode.addChildNode(enemy.node)
    }
    
    func setupPlayer(){
        
        player = PlayerEntity(physicsWorld: self.physicsWorld)
        let healthBar = overlay.healthBar
        healthBar.currentHealth = player.healthComponent.currentHealth.value
        healthBar.maxHealth = player.healthComponent.maxHealth.value
        player.healthComponent.currentHealth.addObserver { value in
            healthBar.currentHealth = value
        }
        player.healthComponent.maxHealth.addObserver { value in
            healthBar.maxHealth = value
        }
        
        
        rootNode.addChildNode(player.node)
        player.node.position = SCNVector3(x: 0, y: 0, z: -1)
        
        
        GameManager.player = player
    }
    
    func setupScenario(){
        
        let map = SCNScene( named: "Map.scn" )
        map!.rootNode.enumerateChildNodes { (_ child: SCNNode, _ _: UnsafeMutablePointer<ObjCBool>) in
            child.opacity = 1
            child.position = SCNVector3(0, -1, 0)
            child.scale = .init(x: 0.2, y: 0.2, z: 0.2)
            
            if let geometry = child.geometry {
                let shape: SCNPhysicsShape = .init(geometry: geometry, options: [
                    .type: SCNPhysicsShape.ShapeType.concavePolyhedron
                ])
                
                if child.physicsBody == nil {
                    child.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
                    
                    
                }
                
                
            }
            
            child.categoryBitMask = Physics.collisionMeshBitMask
            
            self.rootNode.addChildNode(child)
        }
        
        let colliderMap = SCNScene(named: "collider.scn")
        let colliders = colliderMap?.rootNode.enumerateChildNodes({ collider, _ in
            collider.position = .init(x: 0, y: -1, z: 0)
            collider.scale = .init(x: 0.2, y: 0.2, z: 0.2)
            
            let shape = SCNPhysicsShape(geometry: collider.geometry!, options: [
                .scale: SCNVector3(x: 0.2, y: 0.2, z: 0.2),
                .type: SCNPhysicsShape.ShapeType.concavePolyhedron
            ])
            
            collider.physicsBody?.physicsShape = shape
            collider.opacity = 0.0
            rootNode.addChildNode(collider)
        })
        
       
        
    }
    
    func setupCamera(){
        camera = Camera()
        GameManager.camera = camera
        rootNode.addChildNode(camera.node)
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
        spawners = [SpawnerEntity(isVisible: true, scene: self), SpawnerEntity(isVisible: true, scene: self), SpawnerEntity(isVisible: true, scene: self), SpawnerEntity(isVisible: true, scene: self)]
        
        for spawner in spawners {
            spawner.scene = self
            spawner.waveManager = waveManager
            spawner.scene.rootNode.addChildNode(spawner.spawnPoint)
        }
        
        spawners[0].spawnPoint.position = SCNVector3(-12, -0.5, -22)
        spawners[1].spawnPoint.position = SCNVector3(-8, -0.5, -23)
        spawners[2].spawnPoint.position = SCNVector3(-21, -0.5, -9)
        spawners[3].spawnPoint.position = SCNVector3(3, -0.5, -6.6)
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

            let nodesInvolved = [nodeA, nodeB]
            
            for node in nodesInvolved {
                if node.name == "collider"{
                    player.attackComponent.handleAttackContact(target: node)
                    
                }

            }
            
        case Bitmask.katanaCollider.rawValue | Bitmask.enemy.rawValue | Bitmask.character.rawValue:
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

