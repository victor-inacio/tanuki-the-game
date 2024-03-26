import Foundation
import SceneKit
import GameplayKit

class WaveIdle: GKState {
    
    var waveManager: WaveManager
    
    init(waveManager: WaveManager){
        self.waveManager = waveManager
    }
    
    override func didEnter(from previousState: GKState?) {
        waveManager.waveNumber = 0
        waveManager.enemiesSpawned = 0
    }
    
    override func willExit(to nextState: GKState) {
        waveManager.waveNumber = 1
        self.stateMachine?.enter(WaveHoard1.self)
    }
    
}
