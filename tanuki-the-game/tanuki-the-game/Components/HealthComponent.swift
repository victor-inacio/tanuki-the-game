import SceneKit
import GameplayKit

class HealthComponent: GKComponent {
    
    var maxHealth: Float
    var node: SCNNode
    var currentHealth: Float
    var healthBarNode: SCNNode?
    var receiveDamageCooldown = false
    
    init (health: Float, node: SCNNode) {
        self.maxHealth = health
        self.node = node
        self.currentHealth = health
        super.init()
        
        
        self.healthBarNode = createHeathBar()
        if let healthBarNode = self.healthBarNode {
            node.addChildNode(healthBarNode)
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
    
    func createHeathBar() -> SCNNode {
        let texture = SKTexture(imageNamed: "enemy1")

        let boxGeometry = SCNBox(width: 1, height: 0.1, length: 0, chamferRadius: 0)

        
        let material = SCNMaterial()
        material.diffuse.contents = texture
        
        boxGeometry.materials = [material]
        
        let heathBarNode = SCNNode(geometry: boxGeometry)
        
        let height = node.boundingBox.max.y - node.boundingBox.min.y
        heathBarNode.position.y = height + 0.4
        
        return heathBarNode
    }

    
    private func updateHealthBar() {
        guard let healthBarNode = self.healthBarNode else {
            return
        }
        
        let currentFrame = 6 + 1 - currentHealth / maxHealth * 6
        
        
       
     
    }
    
    public func receiveDamage(damageAmount: Float) {
        
        if receiveDamageCooldown == false{
            self.currentHealth -= damageAmount
        }
        
        if currentHealth <= 0 {
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
            
            updateHealthBar()
            receiveDamageCooldown = true
            node.runAction(.sequence([.wait(duration: 0.5), .run({ _ in
                self.receiveDamageCooldown = false
            })]))
        }
    }
    
    func die() {
        GameManager.removeEntity(entity: self.node.entity!)
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

