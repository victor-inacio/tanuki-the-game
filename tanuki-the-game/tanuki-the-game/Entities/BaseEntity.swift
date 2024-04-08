//
//  BaseEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 13/03/24.
//

import Foundation
import GameplayKit

class BaseEntity: GKEntity{
    
    
    public lazy var visualComponent: VisualComponent = {
        guard let component = component(ofType: VisualComponent.self) else {
            fatalError("VisualComponent not found")
        }
        return component
    }()
    
    public lazy var animationComponent: AnimationComponent = {
        guard let component = component(ofType: AnimationComponent.self) else {
            fatalError("AnimationComponent not found")
        }
        return component
    }()
    
    var model: SCNNode {
        return visualComponent.model
    }
    
    var rotationNode: SCNNode {
        return visualComponent.rotationNode
    }
    
    var node: SCNNode {
        return visualComponent.containerNode
    }
    
    var bodies: [SCNNode] {
        return model.childNodes.filter { node in
            if let geometry = node.geometry {
                return geometry.materials.count > 0
            }
            
            return false
        }
    }
    
    public lazy var healthComponent: HealthComponent = {
        guard let component = component(ofType: HealthComponent.self) else {
            fatalError("Health Component not found")
        }
        return component
    }()
}
