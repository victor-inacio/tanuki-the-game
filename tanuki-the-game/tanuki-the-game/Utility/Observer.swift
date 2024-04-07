class Observer<T> {
    
    public typealias ObserverBlock = (_ value: T) -> Void
    
    let block: ObserverBlock
    
    init(block: @escaping ObserverBlock) {
        self.block = block
    }
    
    
    func update(value: T) {
        self.block(value)
    }
    
}

class Subject<T: Any> {
    
    var observers: [Observer<T>.ObserverBlock] = []
    
    var value: T {
        didSet {
            notify()
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    public func addObserver(observer: @escaping Observer<T>.ObserverBlock) {
        observers.append(observer)
    }
    
    private func notify() {
        for observer in observers {
            observer(value)
        }
    }
    
}
