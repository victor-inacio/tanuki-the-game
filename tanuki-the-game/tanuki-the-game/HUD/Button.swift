import SpriteKit

protocol ButtonDelegate: AnyObject {
    
    func onButtonUp() -> Void
    func onButtonDown() -> Void
    
}

class Button: SKNode {
    
    
    var labelNode: SKLabelNode!
    weak var delegate: ButtonDelegate?
    
    init(label: String) {
        super.init()
        let backgroundSize: CGSize = .init(width: 50, height: 50)
        isUserInteractionEnabled = true
        let labelNode = SKLabelNode(text: label)
        labelNode.text = label
        labelNode.position = .init(x: 0, y:  0)
        
        labelNode.fontColor = .black
        self.labelNode = labelNode
        
    
        let background = SKShapeNode(ellipseIn: .init(x: -backgroundSize.width / 2, y: -backgroundSize.height / 3, width: backgroundSize.width, height: backgroundSize.height))
        background.fillColor = .white
        
        addChild(background)
        addChild(labelNode)
   
    }
    
    public func onButtonDown() {    
        delegate?.onButtonDown()
    }
    
    public func onButtonUp() {
        delegate?.onButtonUp()
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
