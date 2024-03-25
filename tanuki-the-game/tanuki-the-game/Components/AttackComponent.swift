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
    var attackerModel: SCNNode
    var attacker: SCNNode
    var damage: Float
    
    
    init(topLevelNode: SCNNode,attackerModel: SCNNode, ColliderName: String, damage: Float){
        
        swordCollider = attackerModel.childNode(withName: ColliderName, recursively: true)!
        swordCollider.physicsBody?.categoryBitMask = Bitmask.playerWeapon.rawValue
        swordCollider.physicsBody?.contactTestBitMask = Bitmask.enemy.rawValue
        swordCollider.physicsBody?.collisionBitMask = Bitmask.none.rawValue
        self.attackerModel = attackerModel
        self.damage = damage
        self.attacker = topLevelNode
        
        super.init()
    }
    
    public func attack() {
        
    }
    
    public func handleAttackContact(target: BaseEntity) {
        
        target.healthComponent.receiveDamage(damageAmount: damage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

