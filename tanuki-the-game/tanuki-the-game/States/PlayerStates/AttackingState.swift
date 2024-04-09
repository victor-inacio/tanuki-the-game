//
//  AttackingState.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 25/03/24.
//

import Foundation
import GameplayKit

class AttackingState: PlayerState{
    
    var attacking = false
    
    override func didEnter(from previousState: GKState?){
        
        playerModel.animationPlayer(forKey: "attack")?.speed = 2
        playerModel.animationPlayer(forKey: "attack")?.play()
        
        entity.movementComponent.walkSpeed = 3
        
        let animationDuration: TimeInterval = (playerModel.animationPlayer(forKey: "attack")?.animation.duration)! /   entity.movementComponent.speedFactor
        
        entity.node.runAction(.sequence([.wait(duration: animationDuration * 0.2), .run({ _ in
            self.attacking = true
        })]))
        
        
        entity.node.runAction(.sequence([.wait(duration: animationDuration * 0.4), .run({ _ in
            self.stateMachine?.enter(IdleState.self)
            print("animation ended")
        })]))
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
        if stateClass == TransformationState.self{
            return false
        }
        return true
    }
    
    override func willExit(to nextState: GKState){
        attacking = false
        entity.movementComponent.walkSpeed = 1
        playerModel.animationPlayer(forKey: "attack")?.stop(withBlendOutDuration: 0.2)
    }
    
    
    override func update(deltaTime seconds: TimeInterval){
        if attacking{
            
            entity.characterDirection = simd_float2(x: 0, y: 0)
        }
    }
}
