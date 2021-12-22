//
//  TrafficStatusVM.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation
import UIKit

class TrafficStatusVM {
    
    let TrafficCellIdentifier = "TraffiCell"
    @Published var trafficTypes = [TrafficType]()
    
    
    func imageIcon(forCategory category: TrafficCategory) -> UIImage? {
        switch category {
        
        case .metro: return UIImage(named: "metro")
        case .train: return UIImage(named: "train")
        case .local: return UIImage(named: "local")
        case .tram: return UIImage(named: "tram")
        case .bus: return UIImage(named: "bus")
        case .ferry: return UIImage(named: "ferry")
        
        case .unknown: return UIImage(systemName: "square.and.arrow.up.fill")
        
            
        }
    }
    
    
}
