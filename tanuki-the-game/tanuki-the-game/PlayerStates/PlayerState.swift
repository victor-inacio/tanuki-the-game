import GameplayKit

class PlayerState: GKState {
    
    var playerEntity: PlayerEntity
    var playerModel: SCNNode {
        self.playerEntity.model
    }
    
    init(playerEntity: PlayerEntity) {
        self.playerEntity = playerEntity
    }
    
}
