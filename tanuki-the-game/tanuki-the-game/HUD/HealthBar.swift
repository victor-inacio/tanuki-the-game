import SpriteKit

class HealthBar: SKSpriteNode {
    
    var currentHealth: Float! {
        didSet {
            updateTexture()
        }
    }
    var maxHealth: Float! {
        didSet {
            updateTexture()
        }
    }
    
    init(currentHealth: Float, maxHealth: Float) {
        self.currentHealth = currentHealth
        self.maxHealth = maxHealth
        
        let tex: SKTexture = .init(imageNamed: "player1")
        super.init(texture: tex, color: .clear, size: tex.size())
        
        updateTexture()
        
        setScale(0.2)
        
        let controllersPadding = GameManager.scene.overlay.controllers.controllersContainers.calculateAccumulatedFrame()
            
        position = .init(x: controllersPadding.minX + calculateAccumulatedFrame().width / 2, y: controllersPadding.maxY - calculateAccumulatedFrame().height / 2)

        }
    
    private func updateTexture() {
        self.texture = .init(imageNamed: calculateFrame())
    }
    

    
    private func calculateFrame() -> String {

        let frameCount: Float = 7
        let frameName = "player"

        let currentFrame = 1.0 + (frameCount - currentHealth / maxHealth * frameCount)
        
        return frameName + String(currentFrame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
