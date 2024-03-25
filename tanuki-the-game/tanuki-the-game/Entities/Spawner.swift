import Foundation
import SceneKit
import GameplayKit

class SpawnerEntity: GKEntity {
    
    var spawnSphere: SCNNode
    var isVisible: Bool
    var currentDelay: TimeInterval = 0.0
    var currentTime: TimeInterval = 0.0
    var scene: MainScene!
    var waveManager: WaveManager!

    init(isVisible: Bool){
        self.isVisible = isVisible
        let sphere = SCNSphere(radius: 0.5)
            sphere.firstMaterial?.diffuse.contents = UIColor.green
            spawnSphere = SCNNode(geometry: sphere)
        
        if !isVisible {
            spawnSphere.isHidden = true
        } else {
            spawnSphere.isHidden = false
        }
        
        super.init()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawnEnemy() {
        if !waveManager.canSpawn || waveManager.enemiesSpawned == waveManager.toBeSpawned  { return }
        
//        let enemy = EnemyEntity()
//        enemy.cubeEnemy.position = spawnSphere.position
//        scene.rootNode.addChildNode(enemy.cubeEnemy)
//        waveManager.enemiesSpawned += 1
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
