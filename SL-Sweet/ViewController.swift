//
//  ViewController.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-06.
//

import UIKit

class TrafficCell: UITableViewCell {
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fetcher = TrafficStatusFetcher()
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var events = [EventsInfo]()
    
    private let TrafficCellIdentifier = "TraffiCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Traffic State"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hej", style: .plain, target: self, action: #selector(didPressHejButton))
        // Do any additional setup after loading the view.
        tableView.register(TrafficCell.self, forCellReuseIdentifier: TrafficCellIdentifier)
//        tableView.delegate = self
//        tableView.dataSource = self
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
                self.events = data.ResponseData.TrafficTypes[0].Events
                print(self.events)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrafficCellIdentifier, for: indexPath) as? TrafficCell else {
            return UITableViewCell()
        }
        let event = events[indexPath.row]
        cell.textLabel?.text = event.Message
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        title = "Apa"
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}

