//
//  RecognitionDisplayVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-21.
//

import UIKit
import Vision

class RecognitionDisplayVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        //imageView.image = UIImage(named: "boardingGateImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
        
        showCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 20,
                                 y: view.frame.size.height / 4 + 40,
                                 width: view.frame.size.width - 40,
                                 height: view.frame.size.width - 80)
        
        label.frame = CGRect(x: 20,
                             y: view.frame.size.height / 2 + 100,
                             width: view.frame.size.width - 40,
                             height: 200)
    }
    // MARK: - Camera
    
    private func showCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = photo
        imageView.isHidden = false
        recognizeText(image: imageView.image)
        
    }

    // MARK: - Text Recognition
    
    private func recognizeText(image: UIImage?) {
        
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
                    self?.label.text = text
                   // self?.hideLoadingSpinner()
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
