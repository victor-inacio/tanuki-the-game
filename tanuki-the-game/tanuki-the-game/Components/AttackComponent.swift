import SceneKit
import GameplayKit

class AttackComponent: GKComponent {
    
    var attacking = false
    var attacker: SCNNode!

    var scene: SCNScene!

    init(attacker: SCNNode, scene: SCNScene) {
        super.init()
        
        self.attacker = attacker
        self.scene = scene
        attacking = false
    }
    
    public func attack() {

        
        attacking = true
        
        let front = attacker.simdWorldFront
        let (min, max) = attacker.boundingBox
        let width = max.x - min.x
        let height = max.y - min.y
        let boxColliderGeometry = SCNBox(width: CGFloat(width), height: CGFloat(height), length: 1, chamferRadius: 0)
        
        let boxColliderNode = SCNNode()
        scene.rootNode.addChildNode(boxColliderNode)
        
        let boxCollider = SCNPhysicsBody(type: .kinematic, shape: .init(geometry: boxColliderGeometry))
        boxColliderNode.physicsBody = boxCollider
        
        let boxColliderPos = attacker.simdPosition + front * (width + width / 2)
        boxColliderNode.simdPosition = boxColliderPos
        boxColliderNode.simdRotation = attacker.simdRotation
        let contacts = scene.physicsWorld.contactTest(with: boxCollider, options: [:])

//        for contact in contacts {
//            
//            handleAttackContact(node: contact.nodeA)
//            handleAttackContact(node: contact.nodeB)
//            
//        }
        
    }
    
    private func handleAttackContact(node: SCNNode) {
        if (attacker == node) {
            return
        }
        
        let entity = node.entity as? CharacterEntity
        
        if let entity = entity {
            entity.takeDamage(amount: 1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
