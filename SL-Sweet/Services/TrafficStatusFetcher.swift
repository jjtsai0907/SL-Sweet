//
//  TrafficStatusFetcher.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-08.
//

import Foundation

class TrafficStatusFetcher {
    
    
    
    func fetchData (completion: @escaping(Result<TrafficResponse, Error>) -> Void) {
        
        print("Hello ")
        guard let url = URL(string:"https://api.sl.se/api2/trafficsituation.json?key=\(STATUS_APIKEY)") else { print("1"); return }
        
        // Please get your own status ApiKey: https://developer.trafiklab.se/ 
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let model = try JSONDecoder().decode(TrafficResponse.self, from: data)
                print("model: \(model)")
                completion(.success(model))
                
            } catch {
                print("failed \(error)")
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
}
