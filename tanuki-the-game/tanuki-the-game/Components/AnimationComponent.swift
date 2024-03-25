//
//  AnimationComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 20/03/24.
//

import Foundation
import GameplayKit

struct Animation {
    let fromSceneNamed: String
    let animationKey: String
}

class AnimationComponent: GKComponent {
    
    init(nodeToAddAnimation: SCNNode, animations: [Animation]){
        super.init()
       
        for animation in animations {
            let animationPlayer = loadAnimation(fromSceneNamed: animation.fromSceneNamed)
            
            nodeToAddAnimation.addAnimationPlayer(animationPlayer, forKey: animation.animationKey)
            
            animationPlayer.stop()
        }
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
