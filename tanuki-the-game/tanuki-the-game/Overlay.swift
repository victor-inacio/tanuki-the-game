import SpriteKit

class Overlay: SKScene {
    
    var controllers: Controllers!
    
    override init(size: CGSize) {
        super.init(size: size)
        controllers = Controllers(frame: size)
        
        controllers.position = .init(x: 0, y: 100)
        
        addChild(controllers)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let width = frame.size.width
            
            let location = touch.location(in: self)
            
            if (location.x > width / 2) {
                return
            }
            
            controllers.onTouchScreen(touch: touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let width = frame.size.width
            
            let location = touch.location(in: self)
            
            if (location.x > width / 2) {
                return
            }
            
            controllers.onTouchMoved(touches: touches, event: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            controllers.onTouchEnd(touches: touches, event: event)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
