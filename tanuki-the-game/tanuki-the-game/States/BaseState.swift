import GameplayKit

class BaseState<T>: GKState {
    
    var entity: T
    
    init(entity: T) {
        self.entity = entity
    }
    
}
