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
    
    override init(){
       
        super.init()
        stateMachine = EnemyStateMachine(enemy: self)
        
        stateMachine.enter(HuntingState.self)
        self.addComponent(VisualComponent(modelFile:  "Karakasa.scn", nameOfChild: "Armature"))
      
        
        addComponent(AgentComponent(model: model))
        
        agentComponent.position = node.simdWorldPosition
        
        self.addComponent(ColliderComponent(model: model, baseEntity: self))
        
        self.addComponent(HealthComponent(health: 200, node: node))

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
