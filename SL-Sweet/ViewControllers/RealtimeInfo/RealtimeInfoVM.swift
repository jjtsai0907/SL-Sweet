//
//  RealtimeInfoVM.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation
import UIKit

struct RealtimeInfoVM {
    
    func startLoadingSpinner(loadingSpinner: UIActivityIndicatorView) {
        loadingSpinner.startAnimating()
    }
    
    func stopLoadingSpinner(loadingSpinner: UIActivityIndicatorView) {
        loadingSpinner.stopAnimating()
    }
    
}
