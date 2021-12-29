//
//  RealtimeResultVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-27.
//


// URLSession
import UIKit

// Name to an enum is usually with Capitap & singular
private enum RealtimeTrafficType: Int {
    // When you define the first one, the followings will be auto-generated with + 1
    case metro = 0
    case bus
}



class RealtimeResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var nib = UINib(nibName: "RealtimeTableCell", bundle: nil)
    
    var realtimeInfo = RealtimeInfo() {
        didSet {
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "RealtimeTableCell")
    }
    
    
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let trafficType = RealtimeTrafficType(rawValue: section){
            switch trafficType {
            case .metro:
                return "Metro"
            case .bus:
                return "Bus"
            }
        }
        return "Default"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trafficType = RealtimeTrafficType(rawValue: section){
            switch trafficType {
            case .metro:
                return realtimeInfo.ResponseData.Metros.count
            case .bus:
                return realtimeInfo.ResponseData.Buses.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. get the cell. To use custom cell: (1) create a nib (2) register it in viewDidLoad (3) use it below
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealtimeTableCell", for: indexPath) as! RealtimeTableCell
        // 2. determine how many sections, depending on your data type. There are two ways to do this: to switch the enum or the section. I personally think switching enum is cooler.
        

        // Method 1 - switing enum
        if let trafficType = RealtimeTrafficType(rawValue: indexPath.section) {
            switch trafficType {
            case .metro:
                let metro = realtimeInfo.ResponseData.Metros[indexPath.row]
                cell.textLabel?.text = "Metro \(metro.DisplayTime) \(metro.Destination)"
            case .bus:
                let bus = realtimeInfo.ResponseData.Buses[indexPath.row]
                cell.textLabel?.text = "Bus \(bus.DisplayTime) Mot: \(bus.LineNumber)"
            }
        }
        
        /* Method 2 - switching section
         switch indexPath.section {
        case RealtimeTrafficType.bus.rawValue:
        case RealtimeTrafficType.metro.rawValue:
        default:
        }*/
        
        return cell
        
    }



}
