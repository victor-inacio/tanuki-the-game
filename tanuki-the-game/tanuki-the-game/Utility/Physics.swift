import SceneKit

class Physics {
    
    // some constants
    static let gravity = Float(0.004)
    static let minAltitude = Float(-10)
    static let collisionMargin = Float(0.04)
    static let modelOffset = simd_float3(0, -collisionMargin, 0)
    static let collisionMeshBitMask = 8
    
    static func calculateGravityAcceleration(position: simd_float3, downwardAcceleration: simd_float3) -> simd_float3 {
        
        var downwardAcceleration = downwardAcceleration
        
        let up = simd_float3(0, 1, 0)
        var wPosition = position
        // gravity
        downwardAcceleration.y -= Physics.gravity
        wPosition += downwardAcceleration
        let HIT_RANGE = Float(0.2)
        var p0 = wPosition
        var p1 = wPosition
        p0.y = wPosition.y + up.y * HIT_RANGE
        p1.y = wPosition.y - up.y * HIT_RANGE
        
        let options: [String: Any] = [
            SCNHitTestOption.backFaceCulling.rawValue: false,
            SCNHitTestOption.categoryBitMask.rawValue: Physics.collisionMeshBitMask,
            SCNHitTestOption.ignoreHiddenNodes.rawValue: false]
        
        let renderer = GameManager.sceneRenderer!
        
        let hitFrom = SCNVector3(p0)
        let hitTo = SCNVector3(p1)
        let hitResult = renderer.scene!.rootNode.hitTestWithSegment(from: hitFrom, to: hitTo, options: options).first
        
        
        if let hit = hitResult {
            let ground = simd_float3(hit.worldCoordinates)
            if wPosition.y <= ground.y + Physics.collisionMargin {
                
                if downwardAcceleration.y < 0 {
                    downwardAcceleration.y = 0
                }
            }
        }
        
        return downwardAcceleration
        
    }
    
    
    static func calculateSlidePos(position: simd_float3, velocity: simd_float3, collisionShapeOffsetFromModel: simd_float3, collisionShape: SCNPhysicsShape) -> simd_float3 {
        
        if simd_length_squared(velocity) > 10E-4 * 10E-4 {
            let startPosition = position + collisionShapeOffsetFromModel
                
            return Physics.slideInWorld(fromPosition: startPosition, velocity: velocity, collisionShapeOffsetFromModel: collisionShapeOffsetFromModel, collisionShape: collisionShape)
        } else {
            return position
        }
        
    }
    
    static private func slideInWorld(fromPosition start: simd_float3, velocity: simd_float3, collisionShapeOffsetFromModel: simd_float3, collisionShape: SCNPhysicsShape) -> simd_float3 {
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
            
            let physicsWorld = GameManager.scene.physicsWorld
            
            let contacts = physicsWorld.convexSweepTest(
                with: collisionShape,
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
        
        return replacementPoint - collisionShapeOffsetFromModel
    }
    
    static private func handleSlidingAtContact(_ closestContact: SCNPhysicsContact, position start: simd_float3, velocity: simd_float3)
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
        
        
        var normalized = simd_normalize(newDestinationPoint - start)
        
        if (normalized.isNan()) {
            normalized = newDestinationPoint - start
        }
        
        // Advance start position to nearest point without collision.
        let computedVelocity = frictionCoeff * Float(1.0 - closestContact.sweepTestFraction) * originalDistance * normalized
    
        return (computedVelocity, colliderPositionAtContact)
    }
}
