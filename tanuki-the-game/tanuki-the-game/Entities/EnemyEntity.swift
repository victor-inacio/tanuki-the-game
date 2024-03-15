import SpriteKit
import GameplayKit

class EnemyEntity: BaseEntity {

    
    override init(){
        super.init()
        
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
//        
//        self.addComponent(VisualComponent(geometry: cube))
//        
//        self.addComponent(PhysicsBodyComponent(node: self.node, bodyType: .kinematic))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
