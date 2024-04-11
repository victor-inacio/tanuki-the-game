//
//  DrawingModel.swift
//  tanuki-the-game
//
//  Created by Luca on 20/03/24.
//

import CoreML
import UIKit

class CoreMLResult {
    private let model = try? RuneClassifier(configuration: .init())
    
    func result(image: UIImage) -> (prediction: String, probability: Float)? {
        guard let pixelBuffer = image.pixelBuffer(width: 224, height: 224) else {
            print("Error: Unable to convert image to pixel buffer.")
            return nil
        }
        
        guard let prediction = try? model?.prediction(image: pixelBuffer) else {
            print("Error: Model prediction failed.")
            return nil
        }
        
        let predictedClass = prediction.target

        // Find the probability associated with the predicted class
        guard let probability = prediction.targetProbability[predictedClass] else {
            print("Error: Unable to get probability for predicted class.")
            return nil
        }
        
        return (predictedClass, Float(probability))
    }
}

extension UIImage {
    func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
        ] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, attrs, &pixelBuffer)
        
        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(buffer, [])
        defer { CVPixelBufferUnlockBaseAddress(buffer, []) }
        
        guard let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer),
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            return nil
        }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        UIGraphicsPushContext(context)
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        
        return pixelBuffer
    }
}
