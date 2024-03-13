//
//  BaseEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 13/03/24.
//

import Foundation
import GameplayKit

class BaseEntity: GKEntity{
    private lazy var visualComponent: VisualComponent = {
        guard let component = component(ofType: VisualComponent.self) else {
            fatalError("VisualComponent not found")
        }
        return component
    }()
    
    var node: SCNNode {
        return visualComponent.node
    }
}
