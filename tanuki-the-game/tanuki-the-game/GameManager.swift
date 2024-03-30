import SceneKit
import GameplayKit
class GameManager {
    static var entities: [GKEntity] = []
    
    static var player: PlayerEntity?
    static var enemies: [EnemyEntity] {
        return entities.filter { entity in
            entity is EnemyEntity
        } as! [EnemyEntity]
    }
    static var scene: SCNScene!
    static var sceneRenderer: SCNSceneRenderer!
    
    static func addEntity(entity: GKEntity) {
        GameManager.entities.append(entity)
    }
    
    static func removeEntity(entity: GKEntity) {
        GameManager.entities.removeAll { otherEntity in
            
            
            return otherEntity == entity
        }
        
        
    }
    
    
}
