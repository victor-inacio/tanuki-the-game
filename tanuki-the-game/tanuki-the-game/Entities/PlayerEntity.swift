//
//  PlayerEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit

class PlayerEntity: BaseEntity{
   
    var stateMachine: GKStateMachine!
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
        
        self.addComponent(VisualComponent(modelFile:  "Art.scnassets/character/max.scn", nameOfChild: "Max_rootNode"))
        
        setupPlayerHierarchy()
  
        self.addComponent(MovementComponent(topLevelNode: playerNode, rotationNode: playerRotation, modelNode: model, physicsWorld: physicsWorld))
        
        self.addComponent(AnimationComponent(playerModel: model, idle: "Art.scnassets/character/max_idle.scn", idleNameKey: "idle", walking: "Art.scnassets/character/max_walk.scn", walkingNameKey: "walk"))
        
        self.addComponent(AttackComponent(attackerModel: model, ColliderName: "swordCollider"))
        applyMachine()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        if !characterDirection.allZero() && stateMachine.currentState is WalkingState == false{
            stateMachine.enter(WalkingState.self)
        }
        
        if characterDirection.allZero() && stateMachine.currentState is IdleState == false{
            stateMachine.enter(IdleState.self)
        }
    }
    
    func setupPlayerHierarchy(){
        playerNode.addChildNode(playerRotation)
        playerRotation.addChildNode(model)
    }
    
    
    func applyMachine(){
        stateMachine = GKStateMachine(states: [
            IdleState(playerModel: model),
            WalkingState(playerModel: model)
        ])
        stateMachine.enter(IdleState.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
