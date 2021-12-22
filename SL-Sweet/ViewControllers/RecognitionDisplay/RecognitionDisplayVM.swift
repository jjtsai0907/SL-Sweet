//
//  RecognitionDisplayVM.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation
import Vision
import UIKit
import Combine

class RecognitionDisplayVM: ObservableObject {
    
    @Published var resultText = "Default"
    
    
    
    // MARK: - Text Recognition
    
    func recognizeText(image: UIImage?)  {
        
        DispatchQueue.global().async {
            guard let cgImage = image?.cgImage else { return }
            
            // Handler
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            // Request
            let request = VNRecognizeTextRequest { [weak self] request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                    return }
                let text = observations.compactMap({
                    $0.topCandidates(1).first?.string
                }).joined(separator: ", ")
                
                DispatchQueue.main.async {
                    self?.resultText = text
                    //self?.label.text = text
                }
                
                print(text)
            }
            // Process request
            do {
                try handler.perform([request])
            }
            catch {
                print(error)
            }
        }
        
        
        
    }

}
