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
    
    func createHeathBar() -> SCNNode {
        let heathBarGeometry = SCNBox(width: 1, height: 0.15, length: 0, chamferRadius: 0)
        let heathBarMaterial = SCNMaterial()
        heathBarMaterial.diffuse.contents = UIColor.green
        heathBarGeometry.materials = [heathBarMaterial]
        
        let heathBarNode = SCNNode(geometry: heathBarGeometry)
        let height = node.boundingBox.max.y - node.boundingBox.min.y
        heathBarNode.position.y = height + 0.4
        
    
        return heathBarNode
    }
    
    private func updateHealthBar() {
        guard let healthBarNode = self.healthBarNode else {
            return
        }
        let scaleX = CGFloat(currentHealth / maxHealth)
        healthBarNode.scale = SCNVector3(scaleX, 1, 1)
        
        var color: UIColor
        
        switch currentHealth {
           case ..<(maxHealth * 0.25):
               color = .red
           case ..<(maxHealth * 0.5):
               color = .yellow
           default:
               color = .green
           }
           
           if let material = healthBarNode.geometry?.firstMaterial {
               material.diffuse.contents = color
           }
    }
    
    public func receiveDamage(damageAmount: Float) {
        
        if receiveDamageCooldown == false{
            self.currentHealth -= damageAmount
        }
        print(self.currentHealth)
        if currentHealth <= 0 {
            die()
        } else {
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

