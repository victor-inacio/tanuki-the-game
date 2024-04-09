import SpriteKit
import GameplayKit
import SceneKit

class EnemyEntity: BaseEntity {
    
    public lazy var agentComponent: AgentComponent = {
        guard let component = component(ofType: AgentComponent.self) else {
            fatalError("AgentComponent not found")
        }
        return component
    }()
    
    public lazy var movementComponent: MovementComponent = {
        guard let component = component(ofType: MovementComponent.self) else {
            fatalError("MovementComponent not found")
        }
        return component
    }()

    
    var stateMachine: EnemyStateMachine!
    var target: BaseEntity!
    
    override init(){
       
        super.init()
        target = GameManager.player!
        stateMachine = EnemyStateMachine(enemy: self)
        
        
        self.addComponent(VisualComponent(modelFile:  "Karakasa.scn", nameOfChild: "Armature", baseEntity: self))
      
        
        addComponent(AgentComponent(model: model))
        
        agentComponent.position = node.simdWorldPosition
        
        self.addComponent(ColliderComponent(model: model, baseEntity: self))
        
        self.addComponent(HealthComponent(health: 200, node: node))
        
        addComponent(AnimationComponent(nodeToAddAnimation: model, animations: [
            .init(fromSceneNamed: "karakasa_walk.scn", animationKey: "walk"),
            .init(fromSceneNamed: "karakasa_attack.scn", animationKey: "attack")
        ]))
        
        stateMachine.enter(HuntingState.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        stateMachine.update(deltaTime: Time.deltaTime)
        
        agentComponent.update(deltaTime: Time.deltaTime)
        healthComponent.update(deltaTime: Time.deltaTime)
        
        
        node.simdEulerAngles.y = atan2(agentComponent.velocity.x, agentComponent.velocity.z)
        node.simdWorldPosition = agentComponent.position
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
