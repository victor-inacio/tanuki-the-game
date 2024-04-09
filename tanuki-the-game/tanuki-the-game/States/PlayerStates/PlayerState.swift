import GameplayKit

class PlayerState: BaseState<PlayerEntity> {
    
    var playerModel: SCNNode {
        self.entity.model
    }
    
    var setupAnimation: (){
        self.entity.animationComponent.setupAnimation()
    }
    
    var changeToKatana: (){
        self.entity.changeToKatanaModel()
    }
    
    var backToTanuki: (){
        self.entity.backToTanuki()
    }

}
