import SceneKit

class Spawner {
    
    var isRunning: Bool = false
    var delayRange: Range<TimeInterval>
    var currentDelay: TimeInterval = 0.0
    var currentTime: TimeInterval = 0.0
    var bounds: Bounds
    var scene: MainScene
    
    init(bounds: Bounds, delayRange: Range<TimeInterval>, scene: MainScene) {
        self.bounds = bounds
        self.delayRange = delayRange
        self.scene = scene
    }
    
    public func runSpawner() {
        isRunning = true
    }
    
    public func update(_ deltaTime: TimeInterval) {
        if (!isRunning) {
            return
        }
                
        currentTime += deltaTime
        
        if (currentTime >= currentDelay) {
            spawnAtRandom()
            
            currentTime = 0.0
            setNewDelay()
        }
        
    }
    
    private func spawnAtRandom() {
        let randomX = Float.random(in: bounds.min.x...bounds.max.x)
        
        let randomY = Float.random(in: bounds.min.y...bounds.max.y)
        
        let randomZ = Float.random(in: bounds.min.z...bounds.max.z)
        
        
//        let randomPos = simd_float3(randomX, randomY, randomZ)
//        
//        let entity = EnemyEntity()
//        entity.node.simdPosition = randomPos
//        
//        
//        scene.enemyEntities.append(entity)
//        scene.rootNode.addChildNode(entity.node)
    }
    
    private func setNewDelay() {
        
        currentDelay = .random(in: delayRange)
        
    }
    
    public func stopSpawner() {
        
        
        isRunning = false
        currentTime = 0.0
        
    }
    
}
