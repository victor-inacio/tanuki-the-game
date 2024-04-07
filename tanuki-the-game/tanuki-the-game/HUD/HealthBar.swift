import SpriteKit

class HealthBar: SKSpriteNode {
    
    var currentHealth: Float = 0
    var maxHealth: Float = 0
    
    
    
    init() {
        
        let texture: SKTexture = .init(imageNamed: "player1")
        super.init(texture: texture, color: .clear, size: texture.size())

        setScale(0.2)
        
        let controllersPadding = GameManager.scene.overlay.controllers.controllersContainers.calculateAccumulatedFrame()
            
        position = .init(x: controllersPadding.minX + calculateAccumulatedFrame().width / 2, y: controllersPadding.maxY - calculateAccumulatedFrame().height / 2)

        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
