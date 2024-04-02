
import Foundation
import SceneKit
import GameplayKit

class WaveHoard3: GKState {
    
    var waveManager: WaveManager
    
    init(waveManager: WaveManager){
        self.waveManager = waveManager
    }
    
    override func didEnter(from previousState: GKState?) {
        print("hoard3")
        waveManager.enemiesKilled = 0
        waveManager.enemiesSpawned = 0
        waveManager.toBeSpawned = (waveManager.waveNumber * 6 ) * 3
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if waveManager.enemiesKilled == waveManager.toBeSpawned {
            waveManager.waveNumber += 1
            print("WAVE: \(waveManager.waveNumber)")
            self.stateMachine?.enter(WaveHoard1.self)
        }
    }
    
}
