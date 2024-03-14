import SpriteKit

class Controllers: SKNode
{
    let joystick = Joystick()
    let initialJoystickPosition = CGPoint(x: 120, y: 0)
    
    weak var delegate: JoystickDelegate? {
        didSet {
            joystick.delegate = delegate
        }
    }
    
    init(frame: CGSize) {
        super.init()
        
        joystick.position = initialJoystickPosition
        addChild(joystick)
        
        hideJoystick(after: 3.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hideJoystick(after: TimeInterval) {
        let animation = SKAction.sequence([
            .wait(forDuration: after),
            .fadeOut(withDuration: 0.5),
        ])
        
        joystick.run(animation)
    }
    
    private func showJoystick() {
        joystick.alpha = 1.0
    }
    
    public func onTouchScreen(touch: UITouch) {
        showJoystick()
        
        joystick.removeAllActions()
        
        let location = touch.location(in: self)
        joystick.position = location
    }
    
    public func onTouchMoved(touches: Set<UITouch>, event: UIEvent?) {
        joystick.touchesMoved(touches, with: event)
    }
    
    public func onTouchEnd(touches: Set<UITouch>, event: UIEvent?) {
        hideJoystick(after: 1.0)
        joystick.touchesEnded(touches, with: event)
  
    }
    
    private func resetJoystickPos() {
        joystick.position = initialJoystickPosition
    }
    
}
