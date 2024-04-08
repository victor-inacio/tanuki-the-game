import GameplayKit

class PlayerStateMachine: GKStateMachine {
    
    var player: PlayerEntity
    var canEnterState: Bool = true
    
    init(player: PlayerEntity) {
        self.player = player
        
        super.init(states: [
            IdleState(entity: player),
            WalkingState(entity: player),
            AttackingState(entity: player),
            TransformationState(entity: player)
        ])
      
    }
    
    override func enter(_ stateClass: AnyClass) -> Bool {
        if canEnterState{
            return super.enter(stateClass)
        } else {
            return super.enter(TransformationState.self)
        }
        
    }
    
    override func update(deltaTime sec: TimeInterval) {
        super.update(deltaTime: sec)
        
        if player.characterDirection.allZero() && currentState is IdleState == false && currentState is AttackingState == false  {
            enter(IdleState.self)
        }
      
    }
}
