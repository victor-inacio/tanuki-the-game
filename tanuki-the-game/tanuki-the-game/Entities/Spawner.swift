import Foundation
import SceneKit
import GameplayKit

class SpawnerEntity: GKEntity {
    
    var spawnPoint: SCNNode
    var isVisible: Bool
    var currentDelay: TimeInterval = 0.0
    var currentTime: TimeInterval = 0.0
    var scene: MainScene!
    var waveManager: WaveManager!
    var enemy: EnemyEntity!
    static var enemies: [EnemyEntity] = []
  

    init(isVisible: Bool, scene: MainScene){
        self.isVisible = isVisible
        self.scene = scene
        
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
    
    func spawnEnemy(){
        if !waveManager.canSpawn || waveManager.enemiesSpawned == waveManager.toBeSpawned  { return }
        
      
        let enemy = EnemyEntity()
        enemy.enemyNode.position = spawnPoint.position
        enemy.enemyNode.position.z = Float.random(in: 7...9) 
        scene.rootNode.addChildNode(enemy.enemyNode)

        waveManager.enemiesSpawned += 1
        
        SpawnerEntity.enemies.append(enemy)
        print(SpawnerEntity.enemies.count)
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
