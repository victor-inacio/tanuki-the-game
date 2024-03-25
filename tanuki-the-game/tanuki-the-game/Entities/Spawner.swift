import Foundation
import SceneKit
import GameplayKit

class SpawnerEntity: GKEntity {
    
    var spawnPoint: SCNNode
    var isVisible: Bool
    var currentDelay: TimeInterval = 0.0
    var currentTime: TimeInterval = 0.0
    var scene: SCNScene!
    var waveManager: WaveManager!

    init(isVisible: Bool){
        self.isVisible = isVisible
        let sphere = SCNSphere(radius: 0.2)
            sphere.firstMaterial?.diffuse.contents = UIColor.green
            spawnPoint = SCNNode(geometry: sphere)
        
        if !isVisible {
            spawnPoint.isHidden = true
        } else {
            spawnPoint.isHidden = false
        }
        
        super.init()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnEnemy() {
        if !waveManager.canSpawn || waveManager.enemiesSpawned == waveManager.toBeSpawned  { return }
        
        let enemy = EnemyEntity()
        enemy.enemyNode.position = spawnPoint.position
        enemy.enemyNode.position.z += Float.random(in: -5..<5) 
        scene.rootNode.addChildNode(enemy.enemyNode)
        waveManager.enemiesSpawned += 1
    }
    
    func setNewDelay() {
        currentDelay = 2
    }
    
     func update() {
         currentTime += Time.deltaTime
        if (currentTime >= currentDelay) {
            spawnEnemy()
            currentTime = 0.0
            setNewDelay()
        }
    }
    
}
