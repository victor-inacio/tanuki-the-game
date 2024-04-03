import GameplayKit

class HuntingState: EnemyBaseState {
    
    
    
    override func update(deltaTime: TimeInterval) {
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
            let visionRadius = entity.agentComponent.visionRadius
            let separationRadius = entity.agentComponent.separationRadius
            
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

        print(GameManager.player!.node.simdWorldPosition)

    }
    
}
