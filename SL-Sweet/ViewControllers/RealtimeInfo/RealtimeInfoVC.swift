//
//  RealtimeInfoVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import UIKit

class RealtimeInfoVC: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    
    

    private let realtimeInfoVM = RealtimeInfoVM()
    private let realtimeInfoFetcher = RealtimeInfoFetcher()
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var nib = UINib(nibName: "RealtimeTableCell", bundle: nil)
    private var realtimeMetros = [Metro]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingSpinner)
        view.addSubview(tableView)
        tableView.register(nib, forCellReuseIdentifier: "RealtimeTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        loadData()
       
    }
    
    
    func loadData() {
        realtimeInfoVM.startLoadingSpinner(loadingSpinner: loadingSpinner)
        tableView.isHidden = true
        realtimeInfoFetcher.fetchRealtimeInfo() { [weak self] result in
            
            guard let self = self else { return }
            //self.hideLoadingSpinner()
            switch result {
            case .success(let data):
                self.realtimeMetros = data.ResponseData.Metros
                //self.events = data
                //print(self.events)
               
                
                DispatchQueue.main.async {
                    
                    self.realtimeInfoVM.stopLoadingSpinner(loadingSpinner: self.loadingSpinner)
                    self.loadingSpinner.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
                print("fetching real time data...\(data.ResponseData.Metros)")
            case .failure(let error):
                print(error)
            }
            //self.tableView.isHidden = false
        }
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realtimeMetros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealtimeTableCell", for: indexPath) as! RealtimeTableCell
        
        cell.myLabel?.text = "\(realtimeMetros[indexPath.row].GroupOfLine): \(realtimeMetros[indexPath.row].DisplayTime)"
        
        return cell

    }
    

    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        
    }


}
