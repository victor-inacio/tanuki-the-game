//
//  PlayerEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit

class PlayerEntity: BaseEntity{
   
    var stateMachine: PlayerStateMachine!
    let playerNode: SCNNode
    let playerRotation: SCNNode
    
    public lazy var movementComponent: MovementComponent = {
        guard let component = component(ofType: MovementComponent.self) else {
            fatalError("VisualComponent not found")
        }
        return component
    }()
    
    public lazy var attackComponent: AttackComponent = {
        guard let component = component(ofType: AttackComponent.self) else {
            fatalError("VisualComponent not found")
        }
        return component
    }()


    var characterDirection: vector_float2 {
        get {
            return movementComponent.direction
        }
        set {
            var direction = newValue
            let l = simd_length(direction)
            if l > 1.0 {
                direction *= 1 / l
            }
            movementComponent.direction = direction
        }
    }
    
    init(physicsWorld: SCNPhysicsWorld){
        self.playerNode = SCNNode()
        self.playerRotation = SCNNode()
        
        super.init()
        self.stateMachine = PlayerStateMachine(player: self)
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        setupPlayerHierarchy()
  
        self.addComponent(MovementComponent(topLevelNode: playerNode, rotationNode: playerRotation, modelNode: model, physicsWorld: physicsWorld))
        
        self.addComponent(AnimationComponent(nodeToAddAnimation: model, animations: [
            .init(fromSceneNamed: "Art.scnassets/character/max_idle.scn", animationKey: "idle"),
            .init(fromSceneNamed: "Art.scnassets/character/max_walk.scn", animationKey: "walk")
        ]))
        
        self.addComponent(AttackComponent(attackerModel: model, ColliderName: "swordCollider"))
        setupStateMachine()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        characterDirection = Input.movement
        
        stateMachine.update(deltaTime: seconds)
    }
    
    func setupPlayerHierarchy(){
        playerNode.addChildNode(playerRotation)
        playerRotation.addChildNode(model)
    }
    
    
    func setupStateMachine(){
        stateMachine.enter(IdleState.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
