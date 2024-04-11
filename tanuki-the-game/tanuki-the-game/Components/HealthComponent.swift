import SceneKit
import GameplayKit

class HealthComponent: GKComponent {
    
    var maxHealth: Subject<Float>
    var node: SCNNode
    var currentHealth: Subject<Float>
    var healthBarNode: SCNNode?
    var receiveDamageCooldown = false
    var lastFrame = 1
    
    init (health: Float, node: SCNNode, showHealthBar: Bool = true) {
        self.maxHealth = .init(value: health)
        self.node = node
        self.currentHealth = .init(value: health)
        super.init()
        
        
        if (showHealthBar) {
            self.healthBarNode = createHealthBar()
            if let healthBarNode = self.healthBarNode {
                node.addChildNode(healthBarNode)
            }
        }
    }
    
    override func didAddToEntity() {
        let shader = Bundle.main.url(forResource: "damage", withExtension: "shader")
        
        if let shader = shader {
            do {
                for body in (entity as! BaseEntity).bodies {
                    body.geometry?.shaderModifiers = [
                        .fragment: try String(contentsOf: shader, encoding: .utf8)
                    ]
                }
                
            } catch {
                
            }
        }
    }
    
    func createHealthBar() -> SCNNode {
        let texture = SKTexture(imageNamed: "enemy1")
       
        let boxGeometry = SCNBox(width: 1, height: 0.1, length: 0, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = texture
        
        boxGeometry.materials = [material]
        
        let healthBarNode = SCNNode(geometry: boxGeometry)
        
        let height = node.boundingBox.max.y - node.boundingBox.min.y
        healthBarNode.position.y = height + 0.4
        
        return healthBarNode
    }
    
    func animateTexture(withTextureNamed textureName: String, frameRange: ClosedRange<Int>, duration: TimeInterval = 0.08) -> SCNAction {
        return SCNAction.customAction(duration: duration) { node, elapsedTime in
            let frameCount = CGFloat(frameRange.upperBound - frameRange.lowerBound + 1)
            let normalizedTime = (elapsedTime / duration) * frameCount
            let currentFrame = Int(normalizedTime) % Int(frameCount) + frameRange.lowerBound
            let nextFrameTexture = SKTexture(imageNamed: String(format: "%@%d", textureName, currentFrame))
            node.geometry?.firstMaterial?.diffuse.contents = nextFrameTexture
        }
    }
    
    private func updateHealthBar() {
        guard let healthBarNode = self.healthBarNode else {
            return
        }
        
        let currentFrame = Int(17 + 1 - (Float(currentHealth.value / maxHealth.value) * 17))
        
        let animation = animateTexture(withTextureNamed: "enemy", frameRange: lastFrame...currentFrame)
        

        let setTextureAction = SCNAction.run { _ in
                let currentFrameTexture = SKTexture(imageNamed: String(format: "enemy%d", currentFrame))
                healthBarNode.geometry?.firstMaterial?.diffuse.contents = currentFrameTexture
            }
        
        healthBarNode.removeAllActions()
        healthBarNode.runAction(.sequence([animation, setTextureAction])) {
               self.lastFrame = currentFrame
           }

    }
    
    public func receiveDamage(damageAmount: Float) {
        
        if receiveDamageCooldown == false{
            self.currentHealth.value -= damageAmount
            updateHealthBar()
        }
        
        if currentHealth.value <= 0 {
            die()
        } else {
            for body in (entity as! BaseEntity).bodies {
                body.geometry?.firstMaterial?.setValue(1, forKey: "isDamaging")
                
                body.runAction(SCNAction.sequence([
                    .wait(duration: 0.5),
                    .run({ node in
                        node.geometry?.firstMaterial?.setValue(0, forKey: "isDamaging")
                    })
                ]))
            }
            
            receiveDamageCooldown = true
            node.runAction(.sequence([.wait(duration: 0.5), .run({ _ in
                self.receiveDamageCooldown = false
            })]))
        }
    }
    
    func die(){
        
        if let entity = self.node.entity {
            GameManager.removeEntity(entity: self.node.entity!)
        }
       
        self.node.removeFromParentNode()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        healthBarNode?.look(at: GameManager.camera!.node.position)
        healthBarNode?.eulerAngles.z = 0
        healthBarNode?.eulerAngles.y = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

