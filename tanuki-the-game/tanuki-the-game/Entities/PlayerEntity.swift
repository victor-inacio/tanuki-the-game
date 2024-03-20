//
//  PlayerEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit

class PlayerEntity: BaseEntity{
    
    let speed: Float = 2.0
    let playerNode: SCNNode
    let playerRotation: SCNNode
    var physicsWorld: SCNPhysicsWorld!
    var scene: SCNScene!
    
    var attackComponent: AttackComponent {
        guard let attackComp = component(ofType: AttackComponent.self) else {
            fatalError("Attack Component")
        }
        
        return attackComp
    }
   
    init(scene: SCNScene){
        self.playerNode = SCNNode()
        self.playerRotation = SCNNode()
        super.init()
        addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        let attackComponent = AttackComponent(attacker: playerRotation, scene: scene)
        
        addComponent(attackComponent)
        
        playerNode.addChildNode(playerRotation)
        
        playerRotation.addChildNode(model)
        
        
//        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func attack() {
        attackComponent.attack()
    }
    
    public func moveToDir(dir: simd_float2) {
        
        let angle = atan2(dir.y, dir.x)
        let magnitude = simd_length(dir)
      
        if (magnitude > 0) {
            playerRotation.simdEulerAngles = simd_float3(0, angle, 0)
        }
        
        
        
        let front = -playerRotation.simdWorldFront
        let movement = front * speed * magnitude


        playerNode.simdPosition += movement * Float(Time.deltaTime)
    }
    
}
