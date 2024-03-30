class Math {
    
    static func Clamp(value: Float, minVal: Float, maxVal: Float) -> Float {
        return min(maxVal, max(value, minVal))
    }
}

import simd
import Foundation

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
    static let zero = simd_float3(0.0, 0.0, 0.0)
    
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

extension float4 {
    
    init(_ vec3: float3, _ w: Float) {
        self = float4(vec3.x, vec3.y, vec3.z, w)
    }
}

extension float4x4 {
    var upperLeft3x3: float3x3 {
        let (a,b,c,_) = columns
        return float3x3(a.xyz, b.xyz, c.xyz)
    }
    
    init(rotation: float3x3, position: float3) {
        let (a,b,c) = rotation.columns
        self = float4x4(float4(a, 0),
                        float4(b, 0),
                        float4(c, 0),
                        float4(position, 1))
    }
}

extension matrix_float3x3 {

    func toEulerAngles() -> simd_float3 {
        let sy = sqrt(self.columns.0.x * self.columns.0.x +  self.columns.1.x * self.columns.1.x)
        
        var x: Float
        var y: Float
        var z: Float
        
        if sy > 1e-6 {
            x = atan2(self.columns.2.y, self.columns.2.z)
            y = atan2(-self.columns.2.x, sy)
            z = atan2(self.columns.1.x, self.columns.0.x)
        } else {
            x = atan2(-self.columns.1.z, self.columns.1.y)
            y = atan2(-self.columns.2.x, sy)
            z = 0
        }
        
        return simd_float3(x, y, z)
    }
    
}
