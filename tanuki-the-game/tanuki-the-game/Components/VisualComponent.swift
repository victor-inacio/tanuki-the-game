//
//  VisualComponent.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit


class VisualComponent: GKComponent {
    var containerNode = SCNNode()
    var rotationNode = SCNNode()
    var model: SCNNode!
    var katanaModel: SCNNode!
    var baseEntity: GKEntity
    
    
    
    init(modelFile: String, nameOfChild: String, baseEntity: GKEntity){
   
        let scene = SCNScene(named: modelFile)!
        model = scene.rootNode.childNode( withName: nameOfChild , recursively: true)

        rotationNode.addChildNode(model)
        containerNode.addChildNode(rotationNode)
        self.baseEntity = baseEntity
        super.init()
        
    }
    
    func transformTokatana(){
        
        model.opacity = 0
        
        let scene = SCNScene(named: "tanuki.scn")!
        katanaModel = scene.rootNode.childNode( withName: "katana" , recursively: true)!
        containerNode.addChildNode(katanaModel)
        
        katanaModel.addAnimationPlayer(loadAnimation(fromSceneNamed: "katana_spin.scn"), forKey: "spin")
        katanaModel.animationPlayer(forKey: "spin")?.play()
        
        let collider = model.childNode(withName: "katanaCollider", recursively: true)!
        collider.physicsBody?.categoryBitMask = Bitmask.katanaCollider.rawValue
        collider.physicsBody?.contactTestBitMask = Bitmask.enemy.rawValue
        collider.physicsBody?.collisionBitMask = Bitmask.none.rawValue
        collider.entity = baseEntity

    }
    
    func backToTanuki(){

        let collider = model.childNode(withName: "katanaCollider", recursively: true)!
          collider.physicsBody = nil
        
        model.opacity = 1
        katanaModel.removeFromParentNode()
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
