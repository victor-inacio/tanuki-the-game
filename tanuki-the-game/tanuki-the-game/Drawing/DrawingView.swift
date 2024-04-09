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
    
    @Binding var currentView: CoordinatorViewType
    
    @ObservedObject var viewModel: DrawingViewModel
    @ObservedObject var presentationViewModel: PresentationViewModel // Receive the presentationViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.white.ignoresSafeArea()
                HStack{
                    Spacer()
                    if viewModel.classificationResult == "sword" && viewModel.probability*100 >= 85{
                        ZStack{
                            ZStack{
                                Image(.leaf)
                                    .resizable()
                                    .aspectRatio(1.8, contentMode: .fit)
                                Image(.attackButton)
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .padding()
                            }
                            .padding(.top, 40)
                            VStack{
                                Text("Power Unlocked")
                                    .font(.custom("DarumaDropOne-Regular", size: 20))
                                    .foregroundStyle(.black)
                                    .padding()
                                Spacer()
                            }
                        }
                    }else{
                        ZStack{
                            ZStack{
                                Image(.leaf)
                                    .resizable()
                                    .aspectRatio(1.8, contentMode: .fit)
                                Image(.swordGuide)
                                    .resizable()
                                    .frame(width: 155, height: 280)
                                    .padding()
                                    .opacity(0.5)
                            }
                            .padding(.top, 40)
                            VStack{
                                Text("Draw a sword to unlock your power")
                                    .font(.custom("DarumaDropOne-Regular", size: 20))
                                    .foregroundStyle(.black)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                    
                }
                PKCanvasRepresentation(canvasView: $viewModel.canvasView)
                
                HStack{
                    VStack {
                        Spacer()
                        
                        // Button to classify drawing
                        Button(action: {
                            viewModel.classifyDrawing()
                            print("Classification Result: \(viewModel.classificationResult) \nProbability: \(String(format: "%.2f", viewModel.probability*100))")
                            // Clear canvas after classifying
                            viewModel.canvasView.drawing = PKDrawing()
                            if viewModel.classificationResult == "sword" && viewModel.probability*100 >= 85{
                                print("Ultimate Activated")
                                //Retornar autorização da Ult pro scenekit
                                print("Dismissing view...")
    //                            presentationViewModel.isPresented = false // Dismiss the view using the presentationViewModel
                                withAnimation(.easeInOut(duration: 3)) {
                                    self.currentView = .game
                                }
                                
                            }
                        }) {
                            Image(.drawingSubmit)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Spacer()
                        
                    }.padding(.horizontal, 50)
                    
                    Spacer()
                }
            }
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

//#Preview {
//    DrawingView(viewModel: DrawingViewModel(), presentationViewModel: PresentationViewModel()).environment(Coordinator())
//}
