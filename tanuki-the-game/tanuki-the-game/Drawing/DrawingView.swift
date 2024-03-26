//
//  DrawingView.swift
//  tanuki-the-game
//
//  Created by Luca on 20/03/24.
//

import SwiftUI
import PencilKit
import CoreML
import UIKit

struct DrawingView: View {
    @ObservedObject var viewModel: DrawingViewModel
    @ObservedObject var presentationViewModel: PresentationViewModel // Receive the presentationViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.white.ignoresSafeArea()
                PKCanvasRepresentation(canvasView: $viewModel.canvasView)
            }
            HStack {
                // Button to classify drawing
                Button(action: {
                    print("Classifying drawing...")
                    viewModel.classifyDrawing()
                    // Clear canvas after classifying
                    viewModel.canvasView.drawing = PKDrawing()
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title)
                }
                
                // Button to dismiss the view
                Button(action: {
                    print("Dismissing view...")
                    presentationViewModel.isPresented = false // Dismiss the view using the presentationViewModel
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(.red) // Optionally change the color of the dismiss button
            }
            
            Text("Classification Result: \(viewModel.classificationResult) \nProbability: \(String(format: "%.2f", viewModel.probability*100))")
                .padding()
        }
    }
}

struct PKCanvasRepresentation: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = UIColor.clear
        canvasView.tool = PKInkingTool(.pen, color: UIColor.white, width: 5)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

#Preview {
    DrawingView(viewModel: DrawingViewModel(), presentationViewModel: PresentationViewModel())
}
