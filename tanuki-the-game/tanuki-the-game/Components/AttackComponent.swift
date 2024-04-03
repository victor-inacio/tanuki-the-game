//
//  AttackComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 21/03/24.
//

import SceneKit
import GameplayKit

class AttackComponent: GKComponent {
    
    var weaponCollider: SCNNode
    var attackerModel: SCNNode
    var attacker: SCNNode
    var damage: Float
    var stateMachine: GKStateMachine
    var attackCooldown = false
    
    
    init(topLevelNode: SCNNode,attackerModel: SCNNode, colliderName: String, damage: Float, stateMachine: GKStateMachine){
        
        weaponCollider = attackerModel.childNode(withName: colliderName, recursively: true)!
        weaponCollider.physicsBody?.categoryBitMask = Bitmask.playerWeapon.rawValue
        weaponCollider.physicsBody?.contactTestBitMask = Bitmask.enemy.rawValue
        weaponCollider.physicsBody?.collisionBitMask = Bitmask.none.rawValue
        
        
        self.attackerModel = attackerModel
        self.damage = damage
        self.attacker = topLevelNode
        self.stateMachine = stateMachine
   
        super.init()
    }
    
    public func attack() {
        
    }
   
    public func handleAttackContact(target: SCNNode) {
    
        if let entity = target.entity as? EnemyEntity {
            if stateMachine.currentState is AttackingState && attackCooldown == false {
            entity.healthComponent.receiveDamage(damageAmount: damage)
                attackCooldown = true
                
                attackerModel.runAction(.sequence([.wait(duration: 0.5), .run({ _ in
                    self.attackCooldown = false
                })]))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

