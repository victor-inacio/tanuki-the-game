import GameplayKit

class PlayerState: BaseState<PlayerEntity> {
    
    var playerModel: SCNNode {
        self.entity.model
    }
    
    var katanaTransformation: (){
        self.entity.visualComponent.katanaModel()
    }
    
}
