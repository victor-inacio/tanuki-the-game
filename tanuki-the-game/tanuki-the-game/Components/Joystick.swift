import SpriteKit
import SwiftUI
import simd

class Joystick: SKNode {
    
    
    var circle: SKShapeNode!
    var ring: SKShapeNode!
    
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
        
        print(ring.frame.size)
        
        let vector = simd_float2(x: Float(location.x), y: Float(location.y))
        let magnitude = simd_length(vector)
        let clampMagnitude = Math.Clamp(value: magnitude, minVal: 0, maxVal: Float(componentSize.width + componentSize.width / 2))
        let dir = simd_normalize(vector)
        
        let newVector = dir * clampMagnitude
        
        
        let x = newVector.x
        
        let y = newVector.y
        
        
        
        circle.position = .init(x: CGFloat(x), y: CGFloat(y))
    }
    
    private func resetCircleLoc() {
        
        circle.position = CGPoint.zero
        
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
