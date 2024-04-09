import GameplayKit

class TransformationState: PlayerState{
    
    override func didEnter(from previousState: GKState?){
        
        print("transforming")
        
        entity.visualComponent.transformTokatana()
        
        playerModel.runAction(.sequence([.wait(duration: 5), .run({ SCNNode in
            self.entity.visualComponent.backToTanuki()
            self.stateMachine?.enter(IdleState.self)
        })]))
       
        entity.movementComponent.walkSpeedFactor = 1.2
    
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
        if stateClass == TransformationState.self || stateClass == AttackingState.self{
            return false
        }
            return true
    }
    
    override func willExit(to nextState: GKState){
       
        entity.movementComponent.walkSpeedFactor = 3.0

    }

    
    override func update(deltaTime seconds: TimeInterval){
        
    }
}
