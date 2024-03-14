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
    
    override init(){
        super.init()
        
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        
        self.addComponent(VisualComponent(geometry: cube))
        
        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func moveToDir(dir: simd_float2) {
        
        let angle = atan2(dir.y, dir.x)
        let magnitude = simd_length(dir)
      
        if (magnitude > 0) {
            node.simdEulerAngles = simd_float3(0, angle, 0)
        }
        
        let front = node.simdWorldFront
        let movement = front * speed * magnitude
        
        node.simdPosition += movement * Float(Time.deltaTime)
    }
    
}
