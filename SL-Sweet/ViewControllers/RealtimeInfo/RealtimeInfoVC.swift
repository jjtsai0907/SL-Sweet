//
//  RealtimeInfoVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import UIKit

class RealtimeInfoVC: UIViewController, UITableViewDelegate ,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
   
    
    
    
    let searchController = UISearchController()

    private let realtimeInfoVM = RealtimeInfoVM()
    private let realtimeInfoFetcher = RealtimeInfoFetcher()
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var nib = UINib(nibName: "RealtimeTableCell", bundle: nil)
    private var realtimeMetros = [Metro]()
    private var realtimeBuses = [Bus]()
    
    
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
                
                self.realtimeMetros = data.ResponseData.Metros
              
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
        
        cell.myLabel.text = "\(realtimeMetros[indexPath.section])"
        return cell

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return realtimeMetros.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Realtime Table"
        // TO DO:
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    // MARK: - UISearchController
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let input = searchController.searchBar.text else { return }
        print(input)
    }
    
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let input = searchBar.text else { return }
        print("Search \(input)...")
    }
    
}
