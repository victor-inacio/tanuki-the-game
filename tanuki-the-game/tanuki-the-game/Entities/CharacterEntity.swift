import GameplayKit
import SceneKit

class CharacterEntity: BaseEntity {
    
    var life: Float = 0.0
    
    
    
    public func takeDamage(amount: Float) {
        
        life -= amount
    }
    
    
}
