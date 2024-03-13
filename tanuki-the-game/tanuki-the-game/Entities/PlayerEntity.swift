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
        
        self.addComponent(VisualComponent(geometry: SCNCapsule(capRadius: 0.5, height: 2)))
        
        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .dynamic))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
