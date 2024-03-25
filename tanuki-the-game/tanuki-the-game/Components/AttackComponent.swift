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
    
    private func handleAttackContact(node: SCNNode) {
        guard let playerEntity = entity as? PlayerEntity else {
            return
        }
        
        guard let enemyEntity = entity as? EnemyEntity else {
            return
        }
        
        if playerEntity == attacker.entity{
            enemyEntity.healthComponent.receiveDamage(damageAmount: damage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//class AttackComponent: GKComponent {
//
//    var attacking = false
//    var attacker: SCNNode!
//
//    var scene: SCNScene!
//
//    init(attacker: SCNNode, scene: SCNScene) {
//        super.init()
//
//        self.attacker = attacker
//        self.scene = scene
//        attacking = false
//    }
//
//    public func attack() {
//
//
//        attacking = true
//
//        let front = attacker.simdWorldFront
//        let (min, max) = attacker.boundingBox
//        let width = max.x - min.x
//        let height = max.y - min.y
//        let boxColliderGeometry = SCNBox(width: CGFloat(width), height: CGFloat(height), length: 1, chamferRadius: 0)
//
//        let boxColliderNode = SCNNode()
//        scene.rootNode.addChildNode(boxColliderNode)
//
//        let boxCollider = SCNPhysicsBody(type: .kinematic, shape: .init(geometry: boxColliderGeometry))
//        boxColliderNode.physicsBody = boxCollider
//
//        let boxColliderPos = attacker.simdPosition + front * (width + width / 2)
//        boxColliderNode.simdPosition = boxColliderPos
//        boxColliderNode.simdRotation = attacker.simdRotation
//        let contacts = scene.physicsWorld.contactTest(with: boxCollider, options: [:])
//
////        for contact in contacts {
////
////            handleAttackContact(node: contact.nodeA)
////            handleAttackContact(node: contact.nodeB)
////
////        }
//
//    }
//
//    private func handleAttackContact(node: SCNNode) {
//        if (attacker == node) {
//            return
//        }
//
//        let entity = node.entity as? CharacterEntity
//
//        if let entity = entity {
//            entity.takeDamage(amount: 1.0)
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}
//
//
