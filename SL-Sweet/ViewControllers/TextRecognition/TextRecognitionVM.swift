//
//  TextRecognitionVM.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation
import UIKit
import Combine

class TextRecognitionVM: ObservableObject {
    
    @Published var recognitionDisplayVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RecognitionDisplayVC")
   
    
   
    
    func navigateToRecognitionDisplay(function: ()-> ()) {
        print("navigateToRecognitionDisplay()")
        function()
        
    }
    
}
