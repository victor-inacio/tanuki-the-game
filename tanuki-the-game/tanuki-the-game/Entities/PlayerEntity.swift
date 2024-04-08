//
//  PlayerEntity.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import Foundation
import GameplayKit

class PlayerEntity: BaseEntity {
   
    var stateMachine: PlayerStateMachine!
    var body: SCNNode {
        
        return model.childNode(withName: "BODY", recursively: true)!
        
    }

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
        super.init()
    
        self.stateMachine = PlayerStateMachine(player: self)
        
        self.addComponent(VisualComponent(modelFile: "tanuki.scn", nameOfChild: "Armature"))

        addComponent(HealthComponent(health: 1000, node: node, showHealthBar: false))
  
        self.addComponent(MovementComponent(topLevelNode: node, rotationNode: rotationNode, modelNode: model, physicsWorld: physicsWorld))
        
        self.addComponent(AnimationComponent(nodeToAddAnimation: model, animations: [
            .init(fromSceneNamed: "tanuki_idle.scn", animationKey: "idle"),
            .init(fromSceneNamed: "tanuki_attack.scn", animationKey: "attack"),
            .init(fromSceneNamed: "tanuki_walk.scn", animationKey: "walk")
           
        ]))
        
        self.addComponent(AttackComponent(topLevelNode: node, attackerModel: model, colliderName: "swordCollider", damage: 80, stateMachine: stateMachine))
        
        
        setupStateMachine()
    }
    
    func changeToKatanaModel() {
        visualComponent.katanaModel()
    }
    
    func backToTanuki(){
        visualComponent.backToTanuki()
    }   
    
    override func update(deltaTime seconds: TimeInterval) {
        
        characterDirection = Input.movement
        
        stateMachine.update(deltaTime: seconds)
        movementComponent.update(deltaTime: seconds)

    }

    func setupStateMachine(){
        stateMachine.enter(IdleState.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
