//
//  TextRecognitionVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-20.
//

import UIKit


class TextRecognitionVC: UIViewController {
    
   // @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    private let viewMocdel = TextRecognitionVM()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    @IBAction func showGallery(_ sender: UIButton) {
       
        viewMocdel.navigateToRecognitionDisplay(){
            navigationController?.pushViewController(viewMocdel.recognitionDisplayVC, animated: true)
        }
        
    }
    
    @IBAction func showCamera(_ sender: UIButton) {
        
        viewMocdel.navigateToRecognitionDisplay(){
            navigationController?.pushViewController(viewMocdel.recognitionDisplayVC, animated: true)
        }
    }
    
    
  
    
    

}
