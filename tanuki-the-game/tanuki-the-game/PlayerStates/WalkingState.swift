//
//  WalkingState.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 20/03/24.
//

import Foundation
import GameplayKit

class WalkingState: PlayerState{
    
    override func didEnter(from previousState: GKState?){
        print("walking")
        playerModel.animationPlayer(forKey: "walk")?.play()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
        playerModel.animationPlayer(forKey: "walk")?.stop(withBlendOutDuration: 0.2)
    }
    
   
    override func update(deltaTime seconds: TimeInterval){
       
    }
}
