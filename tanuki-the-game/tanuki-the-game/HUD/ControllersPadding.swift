import SpriteKit

class ControllersPadding: SKShapeNode {
    
    init(parentFrame: CGSize) {
        super.init()
        let padding = UIEdgeInsets(top: 70, left: 40, bottom: 40, right: 50)
        
        
        
        let _path: CGPath = .init(rect: .init(origin: .init(x: padding.left, y: padding.bottom), size: .init(width: parentFrame.width - padding.right, height: parentFrame.height - padding.top)), transform: .none)
        alpha = 0.0
        path = _path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
