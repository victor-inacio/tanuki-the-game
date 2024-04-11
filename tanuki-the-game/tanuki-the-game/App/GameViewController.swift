//
//  GameViewController.swift
//  tanuki-the-game
//
//  Created by Gabriel Eirado on 11/03/24.
//

import UIKit
import SceneKit
import SwiftUI

class GameViewController: UIViewController {

    @ObservedObject private var presentationViewModel = PresentationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let scnView = SCNView(frame: view.frame)
        

        let scene = MainScene(scnView: scnView)
        
        
        
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.defaultCameraController.interactionMode = .orbitTurntable
        scnView.defaultCameraController.inertiaEnabled = true
        scnView.defaultCameraController.maximumVerticalAngle = 89
        scnView.defaultCameraController.minimumVerticalAngle = -89

        scnView.rendersContinuously = true
        scnView.autoenablesDefaultLighting = true
        


        scene.background.contents = UIColor.black
        
        view.addSubview(scnView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
//        presentPopup()
    }
    
    
    //this NEEDS to be fixed, View currently can't be dismissed.
    func presentPopup() {
        let viewModel = DrawingViewModel() // Create view model instance
        let contentView = DrawingView(currentView: .constant(.drawingView), viewModel: viewModel, presentationViewModel: presentationViewModel) // Pass the presentationViewModel
        
        // Present the ContentView as a popup
        let popupViewController = UIHostingController(rootView: contentView)
        popupViewController.modalPresentationStyle = .overFullScreen // Ensure transparent background
        present(popupViewController, animated: true, completion: nil)
    }
}
