import SpriteKit

class Controllers: SKNode
{
    
    let joystick = Joystick()
    
    init(frame: CGSize) {
        super.init()
        
        
        
        joystick.position = .init(x: 100, y: 0)
        addChild(joystick)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
