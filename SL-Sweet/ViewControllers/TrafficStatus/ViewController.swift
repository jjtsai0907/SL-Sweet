//
//  ViewController.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-06.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let trafficStatusVM = TrafficStatusVM()
    private let fetcher = TrafficStatusFetcher()
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
   
    private var trafficTypes = [TrafficType]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Traffic State"
        tableView.backgroundColor =  #colorLiteral(red: 1, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hej", style: .plain, target: self, action: #selector(didPressHejButton))
        tableView.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
        // tableView.register(TrafficCell.self, forCellReuseIdentifier: TrafficCellIdentifier)
        
        // These two below are already assigned in Storyboard
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        loadData()
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
    
    // MARK: Loading Spinner
    
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: trafficStatusVM.TrafficCellIdentifier, for: indexPath) as? TrafficCell else {
            return UITableViewCell()
        }
        let trafficType = trafficTypes[indexPath.section]
        let event = trafficType.Events[indexPath.row]
//        let event = events[indexPath.row]
        //cell.textLabel?.text = event.Message
        
        cell.cellMessage.text = event.Message.trimmingCharacters(in: .whitespacesAndNewlines)
        return cell
    }

    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let trafficType = trafficTypes[section]
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        //header.backgroundColor = .red
        
        let imageView = UIImageView(image: trafficStatusVM.imageIcon(forCategory: trafficType.currentCategory()))
        header.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 20, width: header.frame.size.height - 10, height: header.frame.size.height - 10)
        
        let label = UILabel(frame: CGRect(x: 20 + imageView.frame.size.width, y: 20, width: header.frame.size.width - 15 - imageView.frame.size.width, height: header.frame.size.height - 10))
        header.addSubview(label)
        label.text = trafficType.Name
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    
}

