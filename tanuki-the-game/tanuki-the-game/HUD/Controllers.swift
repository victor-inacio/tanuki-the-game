import SpriteKit

class Controllers: SKNode
{
    let joystick = Joystick()
    let buttonA = Button(texture: .init(imageNamed: "attack_button"))
    let buttonB = Button(texture: .init(imageNamed: "transform_button"))
    var healthBar: HealthBar!
    var initialJoystickPosition = CGPoint(x: 120, y: 0)
    var parentFrame: CGSize!
    
    public var controllersContainers: ControllersPadding!
    
    weak var delegate: (ButtonDelegate)? {
        didSet {
            buttonA.delegate = delegate
        }
    }
    
    init(frame: CGSize) {
        super.init()
        
        parentFrame = frame
        
        addChild(joystick)
        addChild(buttonA)
        
        addChild(buttonB)
    
        hideJoystick(after: 3.0)
    }
    
    public func setup() {
        
        controllersContainers = .init(parentFrame: parentFrame)
        
        healthBar = .init(currentHealth: 500, maxHealth: 1000)
        let controllersRect = controllersContainers.calculateAccumulatedFrame()
        
        initialJoystickPosition = .init(x: controllersRect.origin.x + joystick.calculateAccumulatedFrame().width / 2, y: controllersRect.origin.y + joystick.calculateAccumulatedFrame().height / 2)
        joystick.position = initialJoystickPosition
        
        
        buttonA.position = .init(x: controllersRect.origin.x + controllersRect.width - buttonA.calculateAccumulatedFrame().height - buttonA.calculateAccumulatedFrame().height / 2, y: controllersRect.origin.y + buttonA.calculateAccumulatedFrame().height / 2)
        
        buttonB.position = .init(x: controllersRect.origin.x + controllersRect.width - buttonB.calculateAccumulatedFrame().height / 2, y: controllersRect.origin.y + buttonB.calculateAccumulatedFrame().height + buttonB.calculateAccumulatedFrame().height / 2)
        
        addChild(healthBar)
        addChild(controllersContainers)
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
