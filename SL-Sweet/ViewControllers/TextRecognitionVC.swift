//
//  TextRecognitionVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-20.
//

import UIKit
import Vision

class TextRecognitionVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    
    
    
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
        
        // Do any additional setup after loading the view.
        view.addSubview(label)
        view.addSubview(imageView)
        
        loadingSpinner.isHidden = true
        
        //showSpinner()
        //showCamera()
        //recognizeText(image: imageView.image)
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
    
    
    @IBAction func showGallery(_ sender: UIButton) {
        print("pressed")
    }
    
    @IBAction func showCamera(_ sender: UIButton) {
        showCamera()
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
    
    // MARK: - Loading Spinner
    
    private func showSpinner() {
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        label.isHidden = true
        imageView.isHidden = true
    }
    
    private func hideLoadingSpinner() {
        loadingSpinner.isHidden = true
        loadingSpinner.stopAnimating()
        label.isHidden = false
        imageView.isHidden = false
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
                    self?.hideLoadingSpinner()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
