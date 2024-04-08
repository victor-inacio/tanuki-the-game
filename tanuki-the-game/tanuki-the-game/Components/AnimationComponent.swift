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
    
    var animations: [Animation]
    var nodeToAddAnimation: SCNNode
    
    init(nodeToAddAnimation: SCNNode, animations: [Animation]){
   
        self.nodeToAddAnimation = nodeToAddAnimation
        self.animations = animations
        super.init()
        setupAnimation()
        
    }
  
    public func setupAnimation(){
        for animation in animations {
            let animationPlayer = loadAnimation(fromSceneNamed: animation.fromSceneNamed)
            
            animationPlayer.animation.isRemovedOnCompletion = false
            
            nodeToAddAnimation.addAnimationPlayer(animationPlayer, forKey: animation.animationKey)

            animationPlayer.stop()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
