//
//  IdleState.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 20/03/24.
//

import Foundation
import GameplayKit

class IdleState: PlayerState{
    
    override func didEnter(from previousState: GKState?){
        playerModel.animationPlayer(forKey: "idle")?.play()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
        playerModel.animationPlayer(forKey: "idle")?.stop(withBlendOutDuration: 0.1)
    }
    
    override func update(deltaTime seconds: TimeInterval){
        if (!entity.characterDirection.allZero()) && stateMachine?.currentState is AttackingState == false {
            entity.stateMachine.enter(WalkingState.self)
        }
    }
}
