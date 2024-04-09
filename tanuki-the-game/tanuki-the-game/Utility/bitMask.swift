//
//  bitMask.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 19/03/24.
//

enum Bitmask {
    case character
    case collision
    case enemy
    case playerWeapon
    case ground
    case katanaCollider
    case none

    var rawValue: Int {
        switch self {
        case .character: return 1 << 0
        case .collision: return 1 << 1
        case .enemy: return 1 << 2
        case .playerWeapon: return 1 << 3
        case .ground: return 1 << 4
        case .katanaCollider: return 1 << 5 
        case .none: return 0
        }
    }
}

