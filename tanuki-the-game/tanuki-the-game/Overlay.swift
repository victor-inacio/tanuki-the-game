import SpriteKit

class Overlay: SKScene {
    
    var controllers: Controllers!
    
    override init(size: CGSize) {
        super.init(size: size)
        controllers = Controllers(frame: size)
        
        controllers.position = .init(x: 0, y: 100)
        
        addChild(controllers)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
