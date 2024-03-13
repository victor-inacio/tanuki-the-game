//
//  ScenarioEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 13/03/24.
//

import Foundation
import GameplayKit

class ScenarioEntity: BaseEntity{
    
    override init(){
        super.init()
        
        let plane = SCNPlane(width: 10, height: 10)
        plane.firstMaterial?.diffuse.contents = UIColor(red: 0.13, green: 0.55, blue: 0.13, alpha: 1.00)
        
        self.addComponent(VisualComponent(geometry: plane))
        
        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .static))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
