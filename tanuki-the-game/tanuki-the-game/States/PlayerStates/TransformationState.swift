import GameplayKit

class TransformationState: PlayerState{
    
    override func didEnter(from previousState: GKState?){
    
        katanaTransformation
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool{
      return true
    }
    
    override func willExit(to nextState: GKState){
       
    }
    
   
    override func update(deltaTime seconds: TimeInterval){
  
    }
}
