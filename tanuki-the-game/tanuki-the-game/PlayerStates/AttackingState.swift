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
        
        player.movementComponent.speedFactor*=2.2
        
        
        player.playerNode.runAction(.sequence([.wait(duration: 0.1), .run({ _ in
            self.attacking = true
        })]))
       
        
        player.playerNode.runAction(.sequence([.wait(duration: 0.5), .run({ _ in
            self.stateMachine?.enter(IdleState.self)
        })]))
         
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
        attacking = false
        player.movementComponent.speedFactor = 2
    }
    
   
    override func update(deltaTime seconds: TimeInterval){
        if attacking{
            
            player.characterDirection = simd_float2(x: 0, y: 0)
        }
    }
}
