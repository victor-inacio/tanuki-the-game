import GameplayKit

class TransformationState: PlayerState{
    
    override func didEnter(from previousState: GKState?){
        
        print("transforming")
        
        changeToKatana
        
        
        playerModel.runAction(.sequence([.wait(duration: 5), .run({ SCNNode in
            self.backToTanuki
            self.stateMachine?.enter(IdleState.self)
        })]))
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
        if stateClass == TransformationState.self || stateClass == AttackingState.self{
            return false
        }
            return true
    }
    
    override func willExit(to nextState: GKState){
        
    }
    
    
    override func update(deltaTime seconds: TimeInterval){
        
    }
}
