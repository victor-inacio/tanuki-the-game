//
//  HealthComponent.swift
//  tanuki-the-game
//
//  Created by Bruno Teodoro on 22/03/24.
//

import SceneKit
import GameplayKit

class HealthComponent: GKComponent {
    
    var health: Float
    
    init (health: Float) {
        self.health = health
        super.init()
    }
    
    public func receiveDamage(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
