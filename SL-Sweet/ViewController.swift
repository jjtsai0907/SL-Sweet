//
//  ViewController.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-06.
//

import UIKit

//enum TrafficTypesIcons {
//    case bus = "buss"
//    case tram = "spårvagn"
//    case subway = "tunne"
//}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fetcher = TrafficStatusFetcher()
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var trafficTypes = [TrafficType]()
    
    private let TrafficCellIdentifier = "TraffiCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Traffic State"
        tableView.backgroundColor =  #colorLiteral(red: 1, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hej", style: .plain, target: self, action: #selector(didPressHejButton))
        tableView.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
        // tableView.register(TrafficCell.self, forCellReuseIdentifier: TrafficCellIdentifier)
        
        // These two below are already assigned in Storyboard
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        loadData()
    }
    
    @objc func didPressHejButton() {
        print("Hej")
    }
    
    func loadData() {
        showLoadingSpinner()
        tableView.isHidden = true
        fetcher.fetchData() { [weak self] result in
            guard let self = self else { return }
            self.hideLoadingSpinner()
            switch result {
            case .success(let data):
                self.trafficTypes = data.ResponseData.TrafficTypes
                //self.events = data
                //print(self.events)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            self.tableView.isHidden = false
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
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trafficTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trafficTypes[section].Events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrafficCellIdentifier, for: indexPath) as? TrafficCell else {
            return UITableViewCell()
        }
        let trafficType = trafficTypes[indexPath.section]
        let event = trafficType.Events[indexPath.row]
//        let event = events[indexPath.row]
        //cell.textLabel?.text = event.Message
        
        cell.cellMessage.text = event.Message.trimmingCharacters(in: .whitespacesAndNewlines)
        return cell
    }

    
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let trafficType = trafficTypes[section]
        print(trafficType.currentCategory())
        print(trafficType.Type)
//        switch trafficType.Name {
//        case TrafficTypesIcons.subway:
//            <#code#>
//        default:
//            <#code#>
//        }
        let emoji = emoji(forCategory: trafficType.currentCategory())
        return emoji //"\(emoji) \(trafficType.Name)"
        
    }*/
    
    func imageIcon(forCategory category: TrafficCategory) -> UIImage? {
        switch category {
        
        case .metro: return UIImage(systemName: "square.and.arrow.up.fill")
        case .train: return UIImage(systemName: "square.and.arrow.up.fill")
        case .local: return UIImage(systemName: "square.and.arrow.up.fill")
        case .tram: return UIImage(systemName: "square.and.arrow.up.fill")
        case .bus: return UIImage(systemName: "square.and.arrow.up.fill")
        case .ferry: return UIImage(systemName: "square.and.arrow.up.fill")
        
        case .unknown: return UIImage(systemName: "square.and.arrow.up.fill")
        
            
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        title = "Apa"
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}

