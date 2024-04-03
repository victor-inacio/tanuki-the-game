import GameplayKit
import SceneKit

class AIComponent: GKComponent {
    
    var agent: GKAgent3D!
        
    override init() {
        super.init()
        
        let agent = GKAgent3D()
       
        agent.mass = 1
        agent.maxSpeed = 3.0
        agent.speed = 3.0
        agent.maxAcceleration = 10.0
        agent.radius = 2

        self.agent = agent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    override func update(deltaTime seconds: TimeInterval) {
        agent.update(deltaTime: seconds)
        
        
    }
    
    private func closestTarget() -> SCNNode {
        return SCNNode()
    }
    
}
