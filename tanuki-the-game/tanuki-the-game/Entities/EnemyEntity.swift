import SpriteKit
import GameplayKit

class EnemyEntity: BaseEntity {
    let enemyNode: SCNNode
    let enemyRotation: SCNNode
    
    init(enemyNode: SCNNode, enemyRotation: SCNNode){
    
        self.enemyNode = enemyNode
        self.enemyRotation = enemyRotation
        
        super.init()
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        self.addComponent(HealthComponent(health: 100, node: enemyNode))
        //        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
