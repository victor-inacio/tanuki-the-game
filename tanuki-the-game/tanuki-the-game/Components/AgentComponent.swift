import GameplayKit
import SceneKit

class AgentComponent: GKComponent {
    
    var velocity: simd_float3
    var acceleration: simd_float3
    var downwardAcceleration = simd_float3(repeating: 0)
    var position: simd_float3
    var maxSpeed: Float
    var maxForce: Float = 0.5

    private var characterCollisionShape: SCNPhysicsShape?
    private var collisionShapeOffsetFromModel = simd_float3.zero
    
    init(model: SCNNode) {
        velocity = .init(x: 0, y: 0, z: 0)
        acceleration = .init(x: 0, y: 0, z: 0)
        position = .init(x: 0, y: 0, z: 0)
        maxSpeed = 1.0
        super.init()
        
        let collider = model.childNode(withName: "collider", recursively: true)!
        collider.physicsBody?.categoryBitMask = Bitmask.character.rawValue
        collider.physicsBody?.contactTestBitMask = 0
        collider.physicsBody?.collisionBitMask = Bitmask.character.rawValue
        
        let (min, max) = model.boundingBox
        let collisionCapsuleRadius = CGFloat(max.x - min.x) * CGFloat(0.4)
        let collisionCapsuleHeight = CGFloat(max.y - min.y)
        
        let collisionGeometry = SCNCapsule(capRadius: collisionCapsuleRadius, height: collisionCapsuleHeight)
        characterCollisionShape = SCNPhysicsShape(geometry: collisionGeometry, options:[.collisionMargin: Physics.collisionMargin])
        collisionShapeOffsetFromModel = simd_float3(0, Float(collisionCapsuleHeight) * 0.51, 0.0)
    }
    
    override func update(deltaTime: TimeInterval) {
        acceleration = .zero
        
        velocity = .zero
        
        velocity += followTarget(target: GameManager.player!.playerNode.simdWorldPosition)
        
        velocity *= Float(deltaTime)
        
        downwardAcceleration = Physics.calculateGravityAcceleration(position: position, downwardAcceleration: downwardAcceleration)

        
        velocity += downwardAcceleration
            
        position = Physics.calculateSlidePos(position: position, velocity: velocity, collisionShapeOffsetFromModel: collisionShapeOffsetFromModel, collisionShape: characterCollisionShape!)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func followTarget(target: simd_float3) -> simd_float3 {
        
        let offset = target - position
        var targetVel = offset
        
        targetVel.y = 0.0
        
        return targetVel
        
    }
    
}
