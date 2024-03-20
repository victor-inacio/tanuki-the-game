//
//  IdleState.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 20/03/24.
//

import Foundation
import GameplayKit

class IdleState: GKState{
    let playerModel: SCNNode
    
    init(playerModel: SCNNode){
        self.playerModel = playerModel
       
    }
    override func didEnter(from previousState: GKState?){
        playerModel.animationPlayer(forKey: "idle")?.play()
        print("idle")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
       
    }
    override func update(deltaTime seconds: TimeInterval){
       
    }
}
