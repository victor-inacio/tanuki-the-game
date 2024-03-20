//
//  WalkingState.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 20/03/24.
//

import Foundation
import GameplayKit

class WalkingState: GKState{
    
    init(playerModel: SCNNode){

    }
    
    override func didEnter(from previousState: GKState?){
     print("walking")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
       
    }
    override func update(deltaTime seconds: TimeInterval){
       
    }
}
