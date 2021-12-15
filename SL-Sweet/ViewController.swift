//
//  ViewController.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-06.
//

import UIKit

class ViewController: UIViewController {
    
    let fetcher = TrafficStatusFetcher()
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData() {
        showLoadingSpinner()
        fetcher.fetchData() { [weak self] result in
            guard let self = self else { return }
            self.hideLoadingSpinner()
            switch result {
            case .success(let data):
                print(data.ResponseData.TrafficTypes[0].Events)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showLoadingSpinner() {
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
    }
    
    func hideLoadingSpinner() {
        loadingSpinner.stopAnimating()
        loadingSpinner.isHidden = true
    }
    
    
    

}

