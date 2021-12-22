//
//  RealtimeInfoVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import UIKit

class RealtimeInfoVC: UIViewController {

    private let realtimeInfoVM = RealtimeInfoVM()
    private let realtimeInfoFetcher = RealtimeInfoFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
       
    }
    
    
    func loadData() {
        realtimeInfoFetcher.fetchRealtimeInfo() { [weak self] result in
            
            guard let self = self else { return }
            //self.hideLoadingSpinner()
            switch result {
            case .success(let data):
                //self.trafficTypes = data.ResponseData.TrafficTypes
                //self.events = data
                //print(self.events)
                //self.tableView.reloadData()
                print("fetching real time data...\(data.ResponseData.Metros)")
            case .failure(let error):
                print(error)
            }
            //self.tableView.isHidden = false
        }
        
    }


}
