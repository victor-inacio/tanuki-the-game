import GameplayKit

class PlayerState: GKState {
    
    var player: PlayerEntity
    var playerModel: SCNNode {
        self.player.model
    }
    
    init(playerEntity: PlayerEntity) {
        self.player = playerEntity
    }
    
}
