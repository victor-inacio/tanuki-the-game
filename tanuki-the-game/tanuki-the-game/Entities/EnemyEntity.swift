import SpriteKit
import GameplayKit

class EnemyEntity: BaseEntity {

    
    public lazy var aiComponent: AIComponent = {
        guard let component = component(ofType: AIComponent.self) else {
            fatalError("AIComponent not found")
        }
        return component
    }()
    
    override init(){
        super.init()
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        
        addComponent(AIComponent())
        
        
        
//        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
//        
//        self.addComponent(VisualComponent(geometry: cube))
//
//        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        aiComponent.update(deltaTime: seconds)

        model.simdPosition = aiComponent.agent.position
        
        model.simdPosition.y = -0.6
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
