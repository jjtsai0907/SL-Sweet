//
//  TextRecognitionVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-20.
//

import UIKit


class TextRecognitionVC: UIViewController {
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    private let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "recognitionDisplayVC")
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        loadingSpinner.isHidden = true
        
        //showSpinner()
        //showCamera()
        //recognizeText(image: imageView.image)
    }
    
    
    
    
    @IBAction func showGallery(_ sender: UIButton) {
       
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showCamera(_ sender: UIButton) {
        navigationController?.pushViewController(vc, animated: true)
        //showCamera()
    }
    
    
    
    
    // MARK: - Loading Spinner
    
    private func showSpinner() {
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        //label.isHidden = true
        //imageView.isHidden = true
    }
    
    private func hideLoadingSpinner() {
        loadingSpinner.isHidden = true
        loadingSpinner.stopAnimating()
        //label.isHidden = false
        //imageView.isHidden = false
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
