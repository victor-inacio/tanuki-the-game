import GameplayKit

class PlayerStateMachine: GKStateMachine {
    
    var player: PlayerEntity
    
    init(player: PlayerEntity) {
        self.player = player
        
        super.init(states: [
            IdleState(playerEntity: player),
            WalkingState(playerEntity: player),
            AttackingState(playerEntity: player)
        ])
      
    }
    
    override func update(deltaTime sec: TimeInterval) {
        super.update(deltaTime: sec)
        
        if player.characterDirection.allZero() && currentState is IdleState == false && currentState is AttackingState == false  {
            enter(IdleState.self)
        }

    }
}
