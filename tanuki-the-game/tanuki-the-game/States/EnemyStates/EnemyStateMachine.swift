import GameplayKit

class EnemyStateMachine: GKStateMachine {
    
    var enemy: EnemyEntity
    var cantEnter = true
    
    
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
