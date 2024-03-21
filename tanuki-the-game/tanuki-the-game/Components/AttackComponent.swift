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
        swordCollider.physicsBody?.collisionBitMask = Int(([ .enemy] as Bitmask).rawValue)
        
        super.init()
    }
    
    public func attack() {
        if let geometryNode = swordCollider.childNodes.first,
           let geometry = geometryNode.geometry {
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red 
            geometry.materials = [material]
        }
    }
    
    private func handleAttackContact(node: SCNNode) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

