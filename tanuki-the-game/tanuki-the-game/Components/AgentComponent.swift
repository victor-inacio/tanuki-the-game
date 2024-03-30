import GameplayKit
import SceneKit

class AgentComponent: GKComponent {
    
    var velocity: simd_float3
    var acceleration: simd_float3
    var position: simd_float3
    var maxSpeed: Float
    var maxForce: Float = 0.5
    
    override init() {
        velocity = .init(x: 0, y: 0, z: 0)
        acceleration = .init(x: 0, y: 0, z: 0)
        position = .init(x: 0, y: 0, z: 0)
        maxSpeed = 1.0
        super.init()

    }
    
    override func update(deltaTime: TimeInterval) {
        acceleration = .zero
        velocity += acceleration
        
        velocity += followTarget(target: GameManager.player!.playerNode.simdWorldPosition)
        
        velocity = simd_normalize(velocity) * Math.Clamp(value: simd_length(velocity), minVal: 0, maxVal: maxSpeed)
        
        position += velocity * Float(deltaTime)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func followTarget(target: simd_float3) -> simd_float3 {
        
        let offset = target - position
        let targetVel = simd_normalize(offset) * Math.Clamp(value: simd_length(offset), minVal: 0, maxVal: maxSpeed)
        
        return targetVel
        
    }
    
}
