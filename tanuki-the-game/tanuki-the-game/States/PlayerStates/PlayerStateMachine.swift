import GameplayKit

class PlayerStateMachine: GKStateMachine {
    
    var player: PlayerEntity
    
    init(player: PlayerEntity) {
        self.player = player
        
        super.init(states: [
            IdleState(entity: player),
            WalkingState(entity: player),
            AttackingState(entity: player),
            TransformationState(entity: player)
        ])
      
    }
    
    override func update(deltaTime sec: TimeInterval) {
        super.update(deltaTime: sec)
        
        if player.characterDirection.allZero() && currentState is IdleState == false && currentState is AttackingState == false  {
            enter(IdleState.self)
        }
      
    }
}
