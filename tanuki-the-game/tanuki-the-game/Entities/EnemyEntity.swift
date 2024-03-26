import SpriteKit
import GameplayKit

class EnemyEntity: BaseEntity {
    let enemyNode: SCNNode
    let enemyRotation: SCNNode
    
    
//    public lazy var attackComponent: AttackComponent = {
//        guard let component = component(ofType: AttackComponent.self) else {
//            fatalError("VisualComponent not found")
//        }
//        return component
//    }()
    
    override init(){
    
        self.enemyNode = SCNNode()
        self.enemyRotation = SCNNode()
        
        super.init()
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        self.addComponent(HealthComponent(health: 100, node: enemyNode))
       
        self.addComponent(ColliderComponent(model: model, baseEntity: self))
        
    
        
        setupEnemyHierarchy()
  
    }
    
 
    func setupEnemyHierarchy(){
        enemyNode.addChildNode(enemyRotation)
        enemyRotation.addChildNode(model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
