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
    case train
    case tram
    case ship
}



class RealtimeResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var nib = UINib(nibName: "RealtimeTableCell", bundle: nil)
    
    var realtimeInfo = RealtimeInfo() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let trafficStatusVM = TrafficStatusVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(nib, forCellReuseIdentifier: "RealtimeTableCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor =  #colorLiteral(red: 1, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
    }
    
    
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
   /* func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let trafficType = RealtimeTrafficType(rawValue: section){
            switch trafficType {
            case .metro:
                return "Metro"
            case .bus:
                return "Bus"
            }
        }
        return "Default"
    } */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trafficType = RealtimeTrafficType(rawValue: section){
            switch trafficType {
            case .metro:
                return realtimeInfo.ResponseData.Metros.count
            case .bus:
                return realtimeInfo.ResponseData.Buses.count
            case .train:
                return realtimeInfo.ResponseData.Trains.count
            case .tram:
                return realtimeInfo.ResponseData.Trams.count
            case .ship:
                return realtimeInfo.ResponseData.Ships.count
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
                cell.myLabel?.text = "\(metro.DisplayTime)     Mot: \(metro.Destination)".trimmingCharacters(in: .whitespacesAndNewlines)
            case .bus:
                let bus = realtimeInfo.ResponseData.Buses[indexPath.row]
                cell.myLabel?.text = "\(bus.DisplayTime)      Mot: \(bus.LineNumber)".trimmingCharacters(in: .whitespacesAndNewlines)
            case .train:
                let train = realtimeInfo.ResponseData.Trains[indexPath.row]
                cell.myLabel?.text = "\(train.DisplayTime)   Mot: \(train.Destination)"
            case .tram:
                let tram = realtimeInfo.ResponseData.Trams[indexPath.row]
                cell.myLabel?.text = "\(tram.DisplayTime)   Mot: \(tram.Destination)"
            case .ship:
                let ship = realtimeInfo.ResponseData.Ships[indexPath.row]
                cell.myLabel?.text = "\(ship.DisplayTime)   Mot: \(ship.Destination)"
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
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Pressed!")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        if let trafficType = RealtimeTrafficType(rawValue: section) {
            switch trafficType {
            case .metro:
                setHeader(category: TrafficCategory.metro, header: header, title: "Metro")
            case .bus:
                setHeader(category: TrafficCategory.bus, header: header, title: "Bus")
            case .train:
                setHeader(category: TrafficCategory.train, header: header, title: "Train")
            case .tram:
                setHeader(category: TrafficCategory.tram, header: header, title: "Tram")
            case .ship:
                setHeader(category: TrafficCategory.ferry, header: header, title: "Ferry")
            }
        }
        
        return header
    }
    
    
    private func setHeader(category: TrafficCategory, header: UIView, title: String) {
        
        let imageView = UIImageView(image: trafficStatusVM.imageIcon(forCategory: category))
        header.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 20, width: header.frame.size.height - 10, height: header.frame.size.height - 10)
        let label = UILabel(frame: CGRect(x: 20 + imageView.frame.size.width, y: 20, width: header.frame.size.width - 15 - imageView.frame.size.width, height: header.frame.size.height - 10))
        header.addSubview(label)
        label.text = title
        
    }

}


