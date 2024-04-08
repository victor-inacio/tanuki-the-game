//
//  DrawingViewModel.swift
//  tanuki-the-game
//
//  Created by Luca on 20/03/24.
//

import SwiftUI
import PencilKit

class DrawingViewModel: ObservableObject {
    @Published var canvasView = PKCanvasView()
    @Published var classificationResult: String = ""
    @Published var probability: Float = 0.0
    
    func classifyDrawing() {
        guard let image = getImageFromCanvas() else { return }
        
        if let result = CoreMLResult().result(image: image) {
            self.classificationResult = result.prediction
            self.probability = result.probability
        } else {
            self.classificationResult = "Unable to classify"
            self.probability = 0.0
        }
    }
    
    func getImageFromCanvas() -> UIImage? {
        let bounds = canvasView.bounds
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: format)
        let image = renderer.image { context in
            UIColor.white.setFill()
            context.fill(bounds)
            canvasView.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }
}

class PresentationViewModel: ObservableObject {
    @Published var isPresented = false
}
