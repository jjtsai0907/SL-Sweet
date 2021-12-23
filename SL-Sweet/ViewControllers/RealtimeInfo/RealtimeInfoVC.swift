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
    
    private var realtimeMetros = [Metro]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingSpinner)
        view.addSubview(tableView)
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
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(realtimeMetros[indexPath.row].GroupOfLine): \(realtimeMetros[indexPath.row].DisplayTime)"
        
        return cell
        /*
         guard let cell = tableView.dequeueReusableCell(withIdentifier: trafficStatusVM.TrafficCellIdentifier, for: indexPath) as? TrafficCell else {
             return UITableViewCell()
         }
         let trafficType = trafficTypes[indexPath.section]
         let event = trafficType.Events[indexPath.row]
 //        let event = events[indexPath.row]
         //cell.textLabel?.text = event.Message
         
         cell.cellMessage.text = event.Message.trimmingCharacters(in: .whitespacesAndNewlines)
         return cell
         */
    }
    
    
    
    /*func setupUI() {
        
       NSLayoutConstraint.activate([
        loadingSpinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        loadingSpinner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loadingSpinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingSpinner.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
       
        
        
    }*/
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        
    }


}
