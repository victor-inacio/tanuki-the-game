import GameplayKit

class EnemyStateMachine: GKStateMachine {
    
    var enemy: EnemyEntity
    
    init(enemy: EnemyEntity) {
        self.enemy = enemy
        
        super.init(states: [
            HuntingState(entity: enemy),
            EnemyAttackState(entity: enemy)
        ])
    }
    
    override func update(deltaTime: TimeInterval) {
        super.update(deltaTime: deltaTime)
        
        
    }
    
}
