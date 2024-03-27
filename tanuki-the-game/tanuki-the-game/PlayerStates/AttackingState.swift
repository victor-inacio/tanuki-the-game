//
//  AttackingState.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 25/03/24.
//

import Foundation
import GameplayKit

class AttackingState: PlayerState{
    
    override func didEnter(from previousState: GKState?){   
        print("attacking")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
       
    }
    override func update(deltaTime seconds: TimeInterval){

    }
}
