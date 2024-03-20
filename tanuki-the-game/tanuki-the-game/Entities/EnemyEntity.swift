import SpriteKit
import GameplayKit

class EnemyEntity: BaseEntity {

    
    override init(){
        super.init()
        
        
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
//
//        self.addComponent(VisualComponent(geometry: cube))
//        
//        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
