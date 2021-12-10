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
        
        fetcher.fetchData(){_ in
            
        }
    }
    
    
    
    
    

}

