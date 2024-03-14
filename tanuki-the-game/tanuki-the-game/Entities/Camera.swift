import Foundation
import SceneKit
import GameplayKit

class Camera: GKEntity {
    
    var node: SCNNode!
    var camera: SCNCamera!
    
    override init(){
        super.init()
        
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        
        cameraNode.camera = camera
        
        self.node = cameraNode
        self.camera = camera
    }
    
    public func followTarget(target: simd_float3, offset: simd_float3) {
        
        var newPos = target
        newPos += offset
    
        node.simdPosition = newPos
        node.simdLook(at: target)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
