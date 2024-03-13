//
//  PlayerEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit

class PlayerEntity: BaseEntity{
    
    override init(){
        super.init()
        
        self.addComponent(VisualComponent(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)))
        
        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .dynamic))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
