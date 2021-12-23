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
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingSpinner)
        
        
        
        
        loadData()
       
    }
    
    
    func loadData() {
        realtimeInfoVM.startLoadingSpinner(loadingSpinner: loadingSpinner)
        
        realtimeInfoFetcher.fetchRealtimeInfo() { [weak self] result in
            
            guard let self = self else { return }
            //self.hideLoadingSpinner()
            switch result {
            case .success(let data):
                //self.trafficTypes = data.ResponseData.TrafficTypes
                //self.events = data
                //print(self.events)
                //self.tableView.reloadData()
                
                DispatchQueue.main.async {
                    self.realtimeInfoVM.stopLoadingSpinner(loadingSpinner: self.loadingSpinner)
                    self.loadingSpinner.isHidden = true
                }
                print("fetching real time data...\(data.ResponseData.Metros)")
            case .failure(let error):
                print(error)
            }
            //self.tableView.isHidden = false
        }
        
    }
    
    
    
    
    
    /*func setupUI() {
        
       NSLayoutConstraint.activate([
        loadingSpinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        loadingSpinner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loadingSpinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingSpinner.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
       
        
        
    }*/


}
