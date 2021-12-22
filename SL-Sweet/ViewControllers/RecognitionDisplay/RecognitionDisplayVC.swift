//
//  RecognitionDisplayVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-21.
//

import UIKit
import Vision
import Combine

class RecognitionDisplayVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    private let recognitionDisplayVM = RecognitionDisplayVM()
    
    /*lazy var recognitionDisplayVM: RecognitionDisplayVM = {
                let viewModel = RecognitionDisplayVM()
                return viewModel
            }()*/
    
    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = "Heyyy"
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
        bindViewModel()
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
        recognitionDisplayVM.recognizeText(image: imageView.image)
        print("Running VM recognizeText()")
        label.text = recognitionDisplayVM.resultText
        
        print("VC recognitionDisplayVM.resultText: \(recognitionDisplayVM.resultText)")
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    private func bindViewModel() {
        
        
        recognitionDisplayVM.$resultText.sink { [weak self] value in
            self?.label.text = value
        }.store(in: &cancellables)
        
        
               
    }

}
