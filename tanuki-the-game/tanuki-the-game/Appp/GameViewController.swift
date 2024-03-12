//
//  GameViewController.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let scnView = SCNView(frame: view.frame)
        

        let scene = MainScene(scnView: scnView)
        
        scnView.scene = scene
//        scnView.allowsCameraControl = true
//        scnView.defaultCameraController.interactionMode = .orbitTurntable
//        scnView.defaultCameraController.inertiaEnabled = true
//        scnView.defaultCameraController.maximumVerticalAngle = 89
//        scnView.defaultCameraController.minimumVerticalAngle = -89
        scene.background.contents = UIColor.black
        
        view.addSubview(scnView)
    }
}
