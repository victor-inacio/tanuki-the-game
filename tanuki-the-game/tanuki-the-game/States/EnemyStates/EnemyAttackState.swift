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
  
        let duration = entity.model.animationPlayer(forKey: "attack")?.animation.duration
 
        animationDuration = duration!
        
        entity.model.animationPlayer(forKey: "attack")?.animation.animationDidStop = { animation, animatable, bool in
            self.stateMachine?.enter(HuntingState.self)
        }

    }
    
    override func willExit(to nextState: GKState) {
        entity.model.animationPlayer(forKey: "attack")?.stop(withBlendOutDuration: 0.2)
    }
    
    override func update(deltaTime: TimeInterval) {
        timer += deltaTime
        
        if (timer >= animationDuration * 0.7 && canAttack) {
            let player = GameManager.player!
            canAttack = false
            player.healthComponent.receiveDamage(damageAmount: 20)
            
            player.body.geometry?.firstMaterial?.setValue(1, forKey: "isDamaging")
            
            player.body.runAction(SCNAction.sequence([
                .wait(duration: 0.5),
                .run({ node in
                    node.geometry?.firstMaterial?.setValue(0, forKey: "isDamaging")
                })
            ]))
            
        }
    }
    
   
    
}
