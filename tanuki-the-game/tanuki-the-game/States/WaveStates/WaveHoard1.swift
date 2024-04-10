
import Foundation
import SceneKit
import GameplayKit

class WaveHoard1: GKState {
    
    var waveManager: WaveManager
    
    init(waveManager: WaveManager){
        self.waveManager = waveManager
    }
    
    override func didEnter(from previousState: GKState?) {
        print("hoard1")
        waveManager.enemiesKilled = 0
        waveManager.enemiesSpawned = 0
        waveManager.toBeSpawned = (waveManager.waveNumber * 6 ) 
        print(waveManager.toBeSpawned)
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if waveManager.enemiesKilled == waveManager.toBeSpawned {
            self.stateMachine?.enter(WaveHoard2.self)
        }
    }
    
}
