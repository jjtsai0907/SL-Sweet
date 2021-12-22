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

class RecognitionDisplayVM: NSObject, ObservableObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @Published var resultText = "Default in VM"
    @Published var imageView = UIImage()
    @Published var picker = UIImagePickerController()
    
    // MARK: - Text Recognition
    
    private func recognizeText(image: UIImage?)  {
        
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
    
    
    // MARK: - Camera
    
    func showCamera(function: () -> () ) {
        //picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        function()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        self.imageView = photo
        //self.imageView.isHidden = false
        
        recognizeText(image: photo)
        print("Running VM recognizeText()")
        //label.text = recognitionDisplayVM.resultText
        
        //print("VC recognitionDisplayVM.resultText: \(recognitionDisplayVM.resultText)")
    }
    
    
    

}
