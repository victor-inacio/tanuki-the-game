//
//  ColliderComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 26/03/24.
//

import Foundation
import GameplayKit

class ColliderComponent: GKComponent {
    
    init (model: SCNNode, baseEntity: GKEntity) {
        super.init()
        
        let collider = model.childNode(withName: "collider", recursively: true)!
        collider.physicsBody?.categoryBitMask =  Bitmask.enemy.rawValue
        collider.physicsBody?.contactTestBitMask = Bitmask.character.rawValue
    
    }
    deinit{
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
