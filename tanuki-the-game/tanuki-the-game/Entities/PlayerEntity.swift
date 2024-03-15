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
    let playerDirection: SCNNode
   
    override init(){
        self.playerNode = SCNNode()
        self.playerDirection = SCNNode()
        super.init()
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        playerNode.addChildNode(playerDirection)
        playerDirection.addChildNode(model)
        
//        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func moveToDir(dir: simd_float2) {
        
        let angle = atan2(dir.y, dir.x)
        let magnitude = simd_length(dir)
      
        if (magnitude > 0) {
            playerNode.simdEulerAngles = simd_float3(0, angle, 0)
        }
        
        let front = playerNode.simdWorldFront
        let movement = front * speed * magnitude

        playerNode.simdPosition += movement * Float(Time.deltaTime)
    }
    
}
