import SpriteKit
import GameplayKit
import SceneKit

class EnemyEntity: BaseEntity {

    var playerNode: SCNNode
    var playerRotation: SCNNode
    
    let agent: GKAgent3D
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
    
    override init(){
        self.playerNode = SCNNode()
        self.playerRotation = SCNNode()
        self.agent = .init()
        agent.speed = 1
        agent.maxSpeed = 3
        agent.maxAcceleration = 3
        agent.behavior = GKBehavior(goal: GKGoal(toSeekAgent: GameManager.player!.agent), weight: 1.0)
        
        super.init()
        
        addComponent(AgentComponent())
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        setupPlayerHierarchy()
//        addComponent(MovementComponent(topLevelNode: playerNode, rotationNode: playerRotation, modelNode: model, physicsWorld: GameManager.scene.physicsWorld, dynamicControl: false))
        
//        addComponent(AIComponent())
        
        agentComponent.position = playerNode.simdPosition

    }
    
    func setupPlayerHierarchy(){
        playerNode.addChildNode(playerRotation)
        playerRotation.addChildNode(model)
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
//        aiComponent.update(deltaTime: seconds)
        
//        playerNode.simdWorldPosition = agent.position
//        playerRotation.simdTransform = float4x4(rotation: agent.rotation, position: .init(x: 0, y: 0, z: 0))
        
        
    
        agentComponent.update(deltaTime: Time.deltaTime)
        
        playerNode.simdEulerAngles.y = atan2(agentComponent.velocity.x, agentComponent.velocity.z)
        playerNode.simdWorldPosition = agentComponent.position
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
