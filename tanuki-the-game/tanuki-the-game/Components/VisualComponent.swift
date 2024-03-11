//
//  VisualComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit


class VisualComponent: GKComponent {
    var node: SCNNode
    
    override init() {
        
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        self.node = SCNNode(geometry: boxGeometry)
        
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
