//
//  MovementComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 19/03/24.
//

import Foundation
import GameplayKit

func planeIntersect(planeNormal: simd_float3, planeDist: Float, rayOrigin: simd_float3, rayDirection: simd_float3) -> Float {
    return (planeDist - simd_dot(planeNormal, rayOrigin)) / simd_dot(planeNormal, rayDirection)
}

class MovementComponent: GKComponent{
    
    static private let stepsCount = 10
    
    static private let initialPosition = simd_float3(0.1, -0.2, 0)
    
    private var characterNode: SCNNode! // top level node
    private var characterOrientation: SCNNode! // the node to rotate to orient the character
    private var model: SCNNode! // the model loaded from the character file

    
    // Physics
    private var characterCollisionShape: SCNPhysicsShape?
    private var collisionShapeOffsetFromModel = simd_float3.zero
    private var downwardAcceleration = simd_float3(repeating: 0)
    
    
    // void playing the step sound too often
    private var lastStepFrame: Int = 0
    private var frameCounter: Int = 0
    
    // Direction
    private var previousUpdateTime: TimeInterval = 0
    private var controllerDirection = simd_float2.zero
    
    private var shouldResetCharacterPosition = false
    var physicsWorld: SCNPhysicsWorld

    var direction = simd_float2()
    
    let dynamicControl: Bool
    
    init(topLevelNode: SCNNode, rotationNode: SCNNode, modelNode: SCNNode, physicsWorld: SCNPhysicsWorld, dynamicControl: Bool = true){
        self.characterNode = topLevelNode
        self.characterOrientation = rotationNode
        self.model = modelNode
        self.physicsWorld = physicsWorld
        self.dynamicControl = dynamicControl
        super.init()
        
        let collider = model.childNode(withName: "collider", recursively: true)!
        collider.physicsBody?.categoryBitMask = Bitmask.character.rawValue
        collider.physicsBody?.contactTestBitMask = 0
        collider.physicsBody?.collisionBitMask = Bitmask.character.rawValue
        
        
        
        // Setup collision shape
        let (min, max) = model.boundingBox
        let collisionCapsuleRadius = CGFloat(max.x - min.x) * CGFloat(0.4)
        let collisionCapsuleHeight = CGFloat(max.y - min.y)
        
        let collisionGeometry = SCNCapsule(capRadius: collisionCapsuleRadius, height: collisionCapsuleHeight)
        characterCollisionShape = SCNPhysicsShape(geometry: collisionGeometry, options:[.collisionMargin: Physics.collisionMargin])
        collisionShapeOffsetFromModel = simd_float3(0, Float(collisionCapsuleHeight) * 0.51, 0.0)
        
    }
    
    func queueResetCharacterPosition() {
        shouldResetCharacterPosition = true
    }
    
    private var directionAngle: CGFloat = 0.0 {
        didSet {
            characterOrientation.simdEulerAngles = .init(x: 0, y: Float(directionAngle), z: 0)
            
        }
    }
    
    var walkSpeed: CGFloat = 1.0 {
        didSet {
            model.animationPlayer(forKey: "walk")?.speed = 1 * walkSpeed
        }
    }

    override func update(deltaTime: TimeInterval) {
        
        frameCounter += 1
        
        var characterVelocity = simd_float3.zero
        let renderer = GameManager.sceneRenderer!
        
        let direction = dynamicControl ?  characterDirection(withPointOfView:renderer.pointOfView) : characterOrientation.simdWorldFront

        let characterSpeed = CGFloat(deltaTime) * 2 * walkSpeed
        
        
        // move
        if !direction.allZero() {
            characterVelocity = (direction * Float(characterSpeed)) / 3
            let runModifier = Float(2.0)
            
            // animation walkSpeed
            walkSpeed = CGFloat(runModifier * simd_length(direction))
            
            // rotate character
            directionAngle = CGFloat(atan2f(direction.x, direction.z))
        }
        
        downwardAcceleration = Physics.calculateGravityAcceleration(position: characterNode.simdWorldPosition, downwardAcceleration: downwardAcceleration)
        
        characterVelocity += downwardAcceleration
        
        
        characterNode.simdWorldPosition = Physics.calculateSlidePos(position: characterNode.simdWorldPosition, velocity: characterVelocity, collisionShapeOffsetFromModel: collisionShapeOffsetFromModel, collisionShape: characterCollisionShape!)
    }
    
    func characterDirection(withPointOfView pointOfView: SCNNode?) -> simd_float3 {
        let controllerDir = self.direction
        if controllerDir.allZero() {
            return simd_float3.zero
        }
        
        var directionWorld = simd_float3.zero
        if let pov = pointOfView {
            let p1 = pov.presentation.simdConvertPosition(simd_float3(controllerDir.x, 0.0, -controllerDir.y), to: nil)
            let p0 = pov.presentation.simdConvertPosition(simd_float3.zero, to: nil)
            
            directionWorld = p1 - p0
            directionWorld.y = 0
            if simd_any(directionWorld != simd_float3.zero) {
                let minControllerSpeedFactor = Float(0.2)
                let maxControllerSpeedFactor = Float(1.0)
                let speed = simd_length(controllerDir) * (maxControllerSpeedFactor - minControllerSpeedFactor) + minControllerSpeedFactor
                directionWorld = speed * simd_normalize(directionWorld)
            }
        }
        
        
        return directionWorld
    }
    
    func slideInWorld(fromPosition start: simd_float3, velocity: simd_float3) {
        let maxSlideIteration: Int = 4
        var iteration = 0
        var stop: Bool = false
        
        var replacementPoint = start
        
        var start = start
        var velocity = velocity
        let options: [SCNPhysicsWorld.TestOption: Any] = [
            SCNPhysicsWorld.TestOption.collisionBitMask: Bitmask.collision.rawValue,
            SCNPhysicsWorld.TestOption.searchMode: SCNPhysicsWorld.TestSearchMode.closest]
        while !stop {
            var from = matrix_identity_float4x4
            from.position = start
            
            var to: matrix_float4x4 = matrix_identity_float4x4
            to.position = start + velocity
            
            let contacts = physicsWorld.convexSweepTest(
                with: characterCollisionShape!,
                from: SCNMatrix4(from),
                to: SCNMatrix4(to),
                options: options)
            if !contacts.isEmpty {
                (velocity, start) = handleSlidingAtContact(contacts.first!, position: start, velocity: velocity)
                iteration += 1
                
                if simd_length_squared(velocity) <= (10E-3 * 10E-3) || iteration >= maxSlideIteration {
                    replacementPoint = start
                    stop = true
                }
            } else {
                replacementPoint = start + velocity
                stop = true
            }
        }
        characterNode!.simdWorldPosition = replacementPoint - collisionShapeOffsetFromModel
    }
    
    private func handleSlidingAtContact(_ closestContact: SCNPhysicsContact, position start: simd_float3, velocity: simd_float3)
    -> (computedVelocity: simd_float3, colliderPositionAtContact: simd_float3) {
        let originalDistance: Float = simd_length(velocity)
        
        let colliderPositionAtContact = start + Float(closestContact.sweepTestFraction) * velocity
        
        // Compute the sliding plane.
        let slidePlaneNormal = simd_float3(closestContact.contactNormal)
        let slidePlaneOrigin = simd_float3(closestContact.contactPoint)
        let centerOffset = slidePlaneOrigin - colliderPositionAtContact
        
        // Compute destination relative to the point of contact.
        let destinationPoint = slidePlaneOrigin + velocity
        
        // We now project the destination point onto the sliding plane.
        let distPlane = simd_dot(slidePlaneOrigin, slidePlaneNormal)
        
        // Project on plane.
        var t = planeIntersect(planeNormal: slidePlaneNormal, planeDist: distPlane,
                               rayOrigin: destinationPoint, rayDirection: slidePlaneNormal)
        
        let normalizedVelocity = velocity * (1.0 / originalDistance)
        let angle = simd_dot(slidePlaneNormal, normalizedVelocity)
        
        var frictionCoeff: Float = 0.3
        if abs(angle) < 0.9 {
            t += 10E-3
            frictionCoeff = 1.0
        }
        let newDestinationPoint = (destinationPoint + t * slidePlaneNormal) - centerOffset
        
        // Advance start position to nearest point without collision.
        let computedVelocity = frictionCoeff * Float(1.0 - closestContact.sweepTestFraction)
        * originalDistance * simd_normalize(newDestinationPoint - start)
        
        return (computedVelocity, colliderPositionAtContact)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


