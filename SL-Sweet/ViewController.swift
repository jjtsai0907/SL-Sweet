//
//  ViewController.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-06.
//

import UIKit

class ViewController: UIViewController {
    
    let fetcher = TrafficStatusFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetcher.fetchData() { result in
            switch result {
            case .success(let data):
                print(data.ResponseData)
            case .failure(let error):
                print(error)
            
            }
            
        }
    }
    
    
    
    
    

}

