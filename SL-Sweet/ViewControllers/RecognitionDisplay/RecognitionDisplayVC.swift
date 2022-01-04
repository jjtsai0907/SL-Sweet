//
//  RecognitionDisplayVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-21.
//

import UIKit
import Vision
import Combine

class RecognitionDisplayVC: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    private let recognitionDisplayVM = RecognitionDisplayVM()
    
    
    
    /*lazy var recognitionDisplayVM: RecognitionDisplayVM = {
                let viewModel = RecognitionDisplayVM()
                return viewModel
            }()*/
    
   /* private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = "Start Text"
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }() */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(label)
        //view.addSubview(imageView)
        
        // Do any additional setup after loading the view.
        bindViewModel()
        recognitionDisplayVM.showCamera {
            self.present(recognitionDisplayVM.picker, animated: true, completion: nil)
        }
    }
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 20,
                                 y: view.frame.size.height / 4 + 40,
                                 width: view.frame.size.width - 40,
                                 height: view.frame.size.width - 80)
        
        label.frame = CGRect(x: 20,
                             y: view.frame.size.height / 2 + 100,
                             width: view.frame.size.width - 40,
                             height: 200)
    }*/
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    private func bindViewModel() {
        
        recognitionDisplayVM.$resultText.sink { [weak self] value in
            self?.label.text = value
        }.store(in: &cancellables)
     
        recognitionDisplayVM.$imageView.sink { [weak self] image in
            self?.imageView.image = image
        }.store(in: &cancellables)
        
        
    }
    @IBAction func startReadText(_ sender: Any) {
        
        if let text = self.label.text {
            SpeechService.shared.startSpeech(text: text)
        } else {
            print("no text")
        }
        
    }
    
}
