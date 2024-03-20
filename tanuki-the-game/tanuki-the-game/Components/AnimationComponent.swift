//
//  AnimationComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 20/03/24.
//

import Foundation
import GameplayKit


class AnimationComponent: GKComponent {
    
    init(playerModel: SCNNode, idle: String, idleNameKey: String, walking: String, walkingNameKey: String){
        super.init()
       
        let idleAnimation = loadAnimation(fromSceneNamed: "Art.scnassets/character/max_idle.scn")
        playerModel.addAnimationPlayer(idleAnimation, forKey: "idle")
        
        let walkAnimation = loadAnimation(fromSceneNamed: "Art.scnassets/character/max_walk.scn")
        playerModel.addAnimationPlayer(walkAnimation, forKey: "walk")
        walkAnimation.stop()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
