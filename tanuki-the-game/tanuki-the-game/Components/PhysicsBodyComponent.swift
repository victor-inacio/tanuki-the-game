//
//  PhysicalBody.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 13/03/24.
//

import Foundation
import Foundation
import GameplayKit


class PhysicsBodyComponent: GKComponent {

    
    init(node: SCNNode, bodyType: SCNPhysicsBodyType?) {
   
        node.physicsBody = SCNPhysicsBody(type: bodyType ?? .static, shape: SCNPhysicsShape(node: node, options: .none))
     
        
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
