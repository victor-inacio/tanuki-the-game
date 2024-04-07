//
//  i.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 05/04/24.
//
import GameplayKit


    func runAnimation(format: String, frameCount: ClosedRange<Int>) -> [SKTexture] {
        return frameCount.map { index in
            let imageName = String(format: format, String(index))
            return SKTexture(imageNamed: imageName)
        }
    }

