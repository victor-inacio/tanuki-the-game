import SpriteKit

protocol ButtonDelegate: AnyObject {
    
    func onButtonUp() -> Void
    func onButtonDown() -> Void
    
}

class Button: SKNode {
    
    weak var delegate: ButtonDelegate?
    
    init(texture: SKTexture) {
        super.init()
        isUserInteractionEnabled = true
        
        let sprite = SKSpriteNode(texture: texture)
        sprite.size = .init(width: 64, height: 64)
        addChild(sprite)

    }
    
    public func onButtonDown() {   
        
        
        delegate?.onButtonDown()
    }
    
    public func onButtonUp() {
        delegate?.onButtonUp()
        print("rdff")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if let first = touches.first {
            onButtonUp()
          
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let first = touches.first {
            onButtonDown()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
