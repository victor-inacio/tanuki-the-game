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
            if stateMachine.currentState is AttackingState{
            entity.healthComponent.receiveDamage(damageAmount: damage)
            }
            if stateMachine.currentState is TransformationState{
            entity.healthComponent.receiveDamage(damageAmount: damage * 2)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

