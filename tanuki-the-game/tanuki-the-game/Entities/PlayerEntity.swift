//
//  PlayerEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit

class PlayerEntity: GKEntity{
    
    private lazy var visualComponent: VisualComponent = {
        guard let component = component(ofType: VisualComponent.self) else {
            fatalError("VisualComponent not found")
        }
        return component
    }()
    
    var node: SCNNode {
        return visualComponent.node
    }
    
    override init(){
        super.init()
        
        addComponent(VisualComponent())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
