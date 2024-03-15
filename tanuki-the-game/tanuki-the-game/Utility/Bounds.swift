import simd

class Bounds {
    
    let center: simd_float3
    let size: simd_float3
    
    var min: simd_float3 {
        return self.center - self.size / 2
    }
    
    var max: simd_float3 {
        return self.center + self.size / 2
    }
    
    init(center: simd_float3, size: simd_float3) {
        
        self.center = center
        self.size = size
        
    }
    
    
    
    
}
