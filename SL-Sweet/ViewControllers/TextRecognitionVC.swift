//
//  TextRecognitionVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-20.
//

import UIKit
import Vision

class TextRecognitionVC: UIViewController {
    
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "Loading.."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "boardingGateImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(label)
        view.addSubview(imageView)
        
        recognizeText(image: imageView.image)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 20,
                                 y: view.safeAreaInsets.top,
                                 width: view.frame.size.width - 40,
                                 height: view.frame.size.width - 40)
        
        label.frame = CGRect(x: 20,
                             y: view.frame.size.width + view.safeAreaInsets.top,
                             width: view.frame.size.width - 40,
                             height: 200)
    }
    
    
    // MARK: - Text Recognition
    
    private func recognizeText(image: UIImage?) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
