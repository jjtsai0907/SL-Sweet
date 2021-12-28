//
//  RealtimeInfoVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import UIKit



class RealtimeInfoVC: UIViewController, UITableViewDelegate ,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
   
    
    let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RealtimeResultVC") as? RealtimeResultVC
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: resultsController)
        return controller
    }()
    

    private let realtimeInfoVM = RealtimeInfoVM()
    private let realtimeInfoFetcher = RealtimeInfoFetcher()
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var nib = UINib(nibName: "RealtimeTableCell", bundle: nil)
    
    
    private var realtimeInfo = RealtimeInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingSpinner)
        view.addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor =  #colorLiteral(red: 1, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        tableView.register(nib, forCellReuseIdentifier: "RealtimeTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
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
                
          
                self.realtimeInfo = data
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
        switch (section) {
        case 0: return realtimeInfo.ResponseData.Metros.count
        case 1: return realtimeInfo.ResponseData.Buses.count
        default: return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealtimeTableCell", for: indexPath) as! RealtimeTableCell
        
        if indexPath.section == 0 {
            let metro = realtimeInfo.ResponseData.Metros[indexPath.row]
            cell.myLabel.text = "\(metro.DisplayTime) \(metro.Destination)"
        } else if indexPath.section == 1 {
            let bus = realtimeInfo.ResponseData.Buses[indexPath.row]
            cell.myLabel.text = "\(bus.DisplayTime) Mot: \(bus.LineNumber)"
        }
        
        //cell.myLabel.text = "\(realtimeMetros[indexPath.section].DisplayTime) Mot: \(realtimeMetros[indexPath.section].Destination)"
        
        //cell.myLabel.text = "\(realtimeInfo)"
        
        return cell

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Metro" : "Bus"
        // TO DO:
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    let emptyRealtimeInfo = RealtimeInfo()
    
    // MARK: - UISearchController
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let input = searchController.searchBar.text else { return }
        resultsController?.realtimeInfo = emptyRealtimeInfo
        print(input)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        resultsController?.realtimeInfo = emptyRealtimeInfo
        print("is canceled")
    }
    
    
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let input = searchBar.text else { return }
        
        realtimeInfoFetcher.searchRealtimeInfo(searchInput: input) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                
                
                DispatchQueue.main.async {
                    self.realtimeInfo = data
                    self.resultsController?.realtimeInfo = data

                    self.realtimeInfoVM.stopLoadingSpinner(loadingSpinner: self.loadingSpinner)
                    self.loadingSpinner.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
        print("Search \(input)...")
       // self.navigationItem.searchController?.dismiss(animated: true, completion: nil)
    }
    
}
