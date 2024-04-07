import GameplayKit

class EnemyAttackState: EnemyBaseState {
    
    var timer: TimeInterval = 0.0
    var animationDuration: TimeInterval = 0.0
    var canAttack = true
    
    override func didEnter(from previousState: GKState?) {
        canAttack = true
        timer = 0.0
        entity.agentComponent.active = false
        entity.model.animationPlayer(forKey: "attack")?.animation.repeatCount = 1
        entity.model.animationPlayer(forKey: "attack")?.play()
        entity.model.animationPlayer(forKey: "attack")?.paused = false
        let duration = entity.model.animationPlayer(forKey: "attack")?.animation.duration
 
        animationDuration = duration!
        
        entity.node.runAction(.sequence([
            .wait(duration: animationDuration),
            .run({ node in
                self.stateMachine?.enter(HuntingState.self)
            })
        ]))
    

    }
    
    override func willExit(to nextState: GKState) {
        entity.model.animationPlayer(forKey: "attack")?.stop(withBlendOutDuration: 0.2)
    }
    
    override func update(deltaTime: TimeInterval) {
        timer += deltaTime
    
        if (timer >= animationDuration * 0.7 && canAttack) {
            let player = GameManager.player!
            canAttack = false
            timer = 0.0
           
            if (canReachAttack()) {
                player.healthComponent.receiveDamage(damageAmount: 20)
            }
        }
    }
    
    private func canReachAttack() -> Bool {
        
        let offset = entity.agentComponent.position - entity.target.node.simdWorldPosition
        let distRange = entity.agentComponent.visionRadius
        let sqrDist = simd_length_squared(offset)
        let isDistanceInRange = sqrDist <= distRange * distRange
        
        let angle = simd_float3.angle(vector1: entity.node.simdWorldFront, vector2: entity.agentComponent.position - entity.target.node.simdWorldPosition)
        let isAngleInRange = angle * 180 / Float.pi <= 30
        
        return isDistanceInRange && isAngleInRange
    }
    
   
    
}
