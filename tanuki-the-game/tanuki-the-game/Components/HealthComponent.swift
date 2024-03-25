//
//  HealthComponent.swift
//  tanuki-the-game
//
//  Created by Bruno Teodoro on 22/03/24.
//

import SceneKit
import GameplayKit

class HealthComponent: GKComponent {
    
    var health: Float
    var node: SCNNode
    
    init (health: Float, node: SCNNode) {
        self.health = health
        self.node = node
        super.init()
    }
    
    public func receiveDamage(damageAmount: Float){
        self.health -= damageAmount
        if health <= 0 {
            node.removeFromParentNode()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
