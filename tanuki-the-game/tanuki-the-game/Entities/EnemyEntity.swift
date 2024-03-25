import SpriteKit
import GameplayKit

class EnemyEntity: BaseEntity {
    let enemyNode: SCNNode
    let enemyRotation: SCNNode
    
    override init(){
    
        self.enemyNode = SCNNode()
        self.enemyRotation = SCNNode()
        
        super.init()
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        self.addComponent(HealthComponent(health: 100, node: enemyNode))
        
        let collider = model.childNode(withName: "collider", recursively: true)!
        collider.physicsBody?.categoryBitMask =  Bitmask.enemy.rawValue | Bitmask.character.rawValue
        collider.physicsBody?.contactTestBitMask = Bitmask.character.rawValue

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
