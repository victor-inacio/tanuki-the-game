import GameplayKit
import SceneKit
import simd

class AgentComponent: GKComponent {
    
    var velocity: simd_float3
    var acceleration: simd_float3
    var downwardAcceleration = simd_float3(repeating: 0)
    var position: simd_float3
    var maxSpeed: Float
    var maxForce: Float = 0.5
    let visionRadius: Float = 3.0
    
    var node: SCNNode {
        let entity = entity as! EnemyEntity
        
        return entity.node
    }
    
    

    private var characterCollisionShape: SCNPhysicsShape?
    private var collisionShapeOffsetFromModel = simd_float3.zero
    
    init(model: SCNNode) {
        velocity = .init(x: 0, y: 0, z: 0)
        acceleration = .init(x: 0, y: 0, z: 0)
        position = .init(x: 0, y: 0, z: 0)
        maxSpeed = 1.0
        super.init()
        
        let collider = model.childNode(withName: "collider", recursively: true)!
        collider.physicsBody?.categoryBitMask = Bitmask.enemy.rawValue
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
             
        acceleration += steerTo(desiredPos: GameManager.player!.playerNode.simdWorldPosition)
        
        if (isCollisionAhead()) {
            
            let avoidDirection = getAvoidDir()
            
            acceleration += steerTo(desiredPos: position + avoidDirection) * 20
        }
        
        velocity += acceleration
        velocity = simd_normalize(velocity) * 1.0
        velocity *= Float(deltaTime)
        
        
        
        downwardAcceleration = Physics.calculateGravityAcceleration(position: position, downwardAcceleration: downwardAcceleration)
        
        velocity += downwardAcceleration
            
        position = Physics.calculateSlidePos(position: position, velocity: velocity, collisionShapeOffsetFromModel: collisionShapeOffsetFromModel, collisionShape: characterCollisionShape!)
    }
    
    private func steerTo(desiredPos: simd_float3) -> simd_float3 {
        let desiredVel = simd_normalize(desiredPos - position) * 2.0
        
        let desiredAcceleration = simd_normalize(desiredVel - velocity) * 0.5
        
        if (desiredAcceleration.isNan()) {
            return .zero
        }
        
        return desiredAcceleration
    }
    
    private func getAvoidDir() -> simd_float3 {
        
        let rayCount: Int = 20
        
        
        for rayIndex in 0..<rayCount {
            
            let angle = Float.pi * 2.0 / Float(rayCount) * Float(rayIndex)
            
            let dir = simd_float3(cos(angle), 0, sin(angle))
            
            let options: [String: Any] = [
                SCNHitTestOption.backFaceCulling.rawValue: false,
                SCNHitTestOption.categoryBitMask.rawValue: Bitmask.enemy.rawValue,
                SCNHitTestOption.ignoreHiddenNodes.rawValue: false]
            
            let from = SCNVector3(position)
            let to = SCNVector3(position + dir * visionRadius)
            
            let hitResult = GameManager.sceneRenderer.scene!.rootNode.hitTestWithSegment(from: from, to: to, options: options).first
            
            if let _ = hitResult {
                return dir
            }
            
        }
        
        return node.simdWorldFront
        
    }
    
    private func isCollisionAhead() -> Bool {
        
        let from = SCNVector3(position + .up * 0.2)
        let to = SCNVector3(position + node.simdWorldFront * visionRadius)
        
        let options: [String: Any] = [
            SCNHitTestOption.backFaceCulling.rawValue: false,
            SCNHitTestOption.categoryBitMask.rawValue: Bitmask.enemy.rawValue,
            SCNHitTestOption.ignoreHiddenNodes.rawValue: false]
        
        let hitResult = GameManager.sceneRenderer.scene!.rootNode.hitTestWithSegment(from: from, to: to, options: options).first
        
        return hitResult != nil
        
        
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
