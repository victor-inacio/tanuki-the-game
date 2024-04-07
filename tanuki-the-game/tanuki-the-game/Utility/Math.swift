class Math {
    
    static func Clamp(value: Float, minVal: Float, maxVal: Float) -> Float {
        return min(maxVal, max(value, minVal))
    }
}

import simd

extension simd_float2 {
    static let zero = simd_float2(0.0, 0.0)
    
    func allZero() -> Bool {
        return x == 0 && y == 0
    }
    static func ==(left: simd_float2, right: simd_float2) -> simd_int2 {
        return simd_int2(left.x == right.x ? -1: 0, left.y == right.y ? -1: 0)
    }
}

extension simd_float3 {
    static var up: Self {
        return .init(x: 0, y: 1, z: 0)
    }
    
    
    
    static let zero = simd_float3(0.0, 0.0, 0.0)
    
    static func angle(vector1: simd_float3, vector2: simd_float3) -> Float {
        
        let dot = simd_dot(vector1, vector2)
        
        let magnitudeA = simd_length(vector1)
        let magnitudeB = simd_length(vector2)
        
        let angleCos = dot / (magnitudeA * magnitudeB)
        
        let angle = acos(angleCos)
        
        return angle
    }
    
    func isZero() -> Bool {
        return x == 0.0 && y == 0.0 && z == 0.0
    }
    
    func allZero() -> Bool {
        return x == 0 && y == 0 && z == 0
    }
    
    
    
    static func clampMagnitude(vector: simd_float3, maxMagnitude: Float) -> simd_float3 {
        
        return simd_normalize(vector) * Swift.min(simd_length(vector), maxMagnitude)
        
    }
    
    func isNan() -> Bool {
        
        return x.isNaN || y.isNaN || z.isNaN
        
    }
    
    static func ==(left: simd_float3, right: simd_float3) -> simd_int3 {
        return simd_int3(left.x == right.x ? -1: 0, left.y == right.y ? -1: 0, left.z == right.z ? -1: 0)
    }
    static func !=(left: simd_float3, right: simd_float3) -> simd_int3 {
        return simd_int3(left.x != right.x ? -1: 0, left.y != right.y ? -1: 0, left.z != right.z ? -1: 0)
    }
}

extension simd_float4 {
    static let zero = simd_float4(0.0, 0.0, 0.0, 0.0)
    
    static func ==(left: simd_float4, right: simd_float4) -> simd_int4 {
        return simd_int4(left.x == right.x ? -1: 0, left.y == right.y ? -1: 0, left.z == right.z ? -1: 0, left.w == right.w ? -1: 0)
    }
    var xyz: simd_float3 {
        get {
            return simd_float3(x, y, z)
        }
        set {
            x = newValue.x
            y = newValue.y
            z = newValue.z
        }
    }
}

extension simd_float4x4 {
    var position: simd_float3 {
        get {
            return columns.3.xyz
        }
        set {
            columns.3.xyz = newValue
        }
    }
}
