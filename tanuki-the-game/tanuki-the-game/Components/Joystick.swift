import SpriteKit
import SwiftUI
import simd

struct JoystickData {
    
    let direction: simd_float2
    let clampDirection: simd_float2
    
}

protocol JoystickDelegate: AnyObject {
    
    func onJoystickChange(_ joystickData: JoystickData)
    
}

class Joystick: SKNode {
    
    
    var circle: SKShapeNode!
    var ring: SKShapeNode!
    weak var delegate: JoystickDelegate?
    
    var currentData: JoystickData? {
        didSet {
            delegate?.onJoystickChange(currentData!)
        }
    }
    
    override init() {
        super.init()
        
        let size: CGSize = .init(width: 100, height: 100)

        isUserInteractionEnabled = true
        
        let ringPath = CGPath(ellipseIn: .init(x: -50, y: -50, width: size.width, height: size.height), transform: nil)
        
        ring = SKShapeNode(path: ringPath)
        
       
        ring.lineWidth = 3
        
    
        circle = SKShapeNode(circleOfRadius: 15)
        circle.fillColor = .white
        
        circle.position = CGPoint.zero
        
        addChild(circle)
        addChild(ring)
        
    }
    
    private func updateCircleLoc(touch: UITouch) {
        let location = touch.location(in: self)
            
        let componentSize = circle.frame.size
        
        let vector = simd_float2(x: Float(location.x), y: Float(location.y))
        let magnitude = simd_length(vector)
        let clampMagnitude = Math.Clamp(value: magnitude, minVal: 0, maxVal: Float(componentSize.width + componentSize.width / 2))
        let dir = simd_normalize(vector)
        
        let newVector = dir * clampMagnitude
        
        let x = newVector.x
        let y = newVector.y
        

        circle.position = .init(x: CGFloat(x), y: CGFloat(y))
        
        currentData = getCurrentData()
    }
    
    private func resetCircleLoc() {
        circle.position = CGPoint.zero
        currentData = getCurrentData()
    }
    
    private func getCurrentData() -> JoystickData {
        
        let circlePos = circle.position
        let circleWidth = circle.frame.size.width
        
        let x = circlePos.x / (circleWidth + circleWidth / 2)
        let y = circlePos.y / (circleWidth + circleWidth / 2)
        
        let direction = simd_float2(x: Float(x), y: Float(y))
        
        var clampedDirection = direction
        
        if (direction.x > 0.3) {
            clampedDirection.x = 1
        }
        
        if (direction.x < -0.3) {
            clampedDirection.x = -1
        }
        
        if (direction.y > 0.3) {
            clampedDirection.y = 1
        }
        
        if (direction.y < -0.3) {
            clampedDirection.y = -1
        }
        
        return .init(direction: direction, clampDirection: clampedDirection)
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            updateCircleLoc(touch: touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            updateCircleLoc(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetCircleLoc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
