//
//  AttackComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 21/03/24.
//

import SceneKit
import GameplayKit

class AttackComponent: GKComponent {
    
    var swordCollider: SCNNode
    
    init(attackerModel: SCNNode, ColliderName: String){

        swordCollider = attackerModel.childNode(withName: ColliderName, recursively: true)!
        swordCollider.physicsBody?.categoryBitMask = Bitmask.playerWeapon.rawValue
        swordCollider.physicsBody?.contactTestBitMask = Bitmask.enemy.rawValue
        swordCollider.physicsBody?.collisionBitMask = Bitmask.none.rawValue
      
        
        super.init()
    }
    
    public func attack() {
      
        
    }
    
    private func handleAttackContact(node: SCNNode) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

