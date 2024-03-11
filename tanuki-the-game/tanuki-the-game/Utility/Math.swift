class Math {
    
    static func Clamp(value: Float, minVal: Float, maxVal: Float) -> Float {
        
        return min(maxVal, max(value, minVal))
        
    }
    
}
