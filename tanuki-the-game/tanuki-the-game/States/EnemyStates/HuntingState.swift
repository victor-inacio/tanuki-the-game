import GameplayKit

class HuntingState: EnemyBaseState {
    
    
    override func didEnter(from previousState: GKState?) {
       
        entity.agentComponent.active = true
        entity.model.animationPlayer(forKey: "walk")?.play()
    }
    override func update(deltaTime: TimeInterval) {
        let visionRadius = entity.agentComponent.visionRadius
        let separationRadius = entity.agentComponent.separationRadius
        let targetPos = entity.target.node.simdWorldPosition
        let offset = targetPos - entity.agentComponent.position
        
        if (simd_length_squared(offset) < separationRadius * separationRadius) {
            stateMachine?.enter(EnemyAttackState.self)
            return
        }
        
        entity.agentComponent.queueSteerTo(disiredPos: GameManager.player!.node.simdWorldPosition)
        
        var neighbours = 0
        var separationOffset: simd_float3 = .zero
        for enemy in GameManager.enemies {
            if (enemy == entity) {
                continue
            }
            
            let otherAgent = enemy.agentComponent
            
            let offset = entity.agentComponent.position - otherAgent.position
            
            let sqrDist = simd_length_squared(offset)
            
            if (sqrDist < visionRadius * visionRadius) {
                neighbours += 1
                
                if (sqrDist < separationRadius * separationRadius) {
                    separationOffset += offset / sqrDist
                }
            }
        }
        
        if (neighbours != 0) {
            separationOffset /= Float(neighbours)
        }
        
        
        if (!separationOffset.allZero()) {
            entity.agentComponent.queueSteerTo(disiredPos: entity.agentComponent.position + separationOffset, amount: 1.5)
        }
        

//        print(GameManager.player!.node.simdWorldPosition)

    }
    
    override func willExit(to nextState: GKState) {
        entity.model.animationPlayer(forKey: "walk")?.stop(withBlendOutDuration: 0.2)
    }
    
}
