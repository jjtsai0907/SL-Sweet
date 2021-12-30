//
//  RealtimeInfoVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import UIKit



class RealtimeInfoVC: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
   
    
    let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RealtimeResultVC") as? RealtimeResultVC
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: resultsController)
        return controller
    }()
    

    private let realtimeInfoVM = RealtimeInfoVM()
    private let realtimeInfoFetcher = RealtimeInfoFetcher()

    private var realtimeInfo = RealtimeInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        
       
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

                }
            case .failure(let error):
                print(error)
            }
        }
        
        print("Search \(input)...")
    }
    
}
