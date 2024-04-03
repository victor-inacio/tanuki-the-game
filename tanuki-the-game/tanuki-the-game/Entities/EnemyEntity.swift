import SpriteKit
import GameplayKit
import SceneKit

class EnemyEntity: BaseEntity {

    var node: SCNNode

    public lazy var aiComponent: AIComponent = {
        guard let component = component(ofType: AIComponent.self) else {
            fatalError("AIComponent not found")
        }
        return component
    }()
    
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
        self.node = SCNNode()
       
        super.init()
        stateMachine = EnemyStateMachine(enemy: self)
        
        stateMachine.enter(HuntingState.self)
        self.addComponent(VisualComponent(modelFile:  "Karakasa.scn", nameOfChild: "Armature"))
        setupPlayerHierarchy()
        
        addComponent(AgentComponent(model: model))
        
        agentComponent.position = node.simdWorldPosition
        
        self.addComponent(ColliderComponent(model: model, baseEntity: self))
        
        self.addComponent(HealthComponent(health: 200, node: node))

    }
    
    func setupPlayerHierarchy(){
        node.addChildNode(playerRotation)
        playerRotation.addChildNode(model)
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
//        aiComponent.update(deltaTime: seconds)
        
//        playerNode.simdWorldPosition = agent.position
//        playerRotation.simdTransform = float4x4(rotation: agent.rotation, position: .init(x: 0, y: 0, z: 0))
        
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
