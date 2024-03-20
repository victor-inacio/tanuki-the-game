//
//  bitMask.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 19/03/24.
//

struct Bitmask: OptionSet {
    let rawValue: Int
    static let character = Bitmask(rawValue: 1 << 0) // the main character
    static let collision = Bitmask(rawValue: 1 << 1) // the ground and walls
    static let enemy = Bitmask(rawValue: 1 << 2) // the enemies
}
