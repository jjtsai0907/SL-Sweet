//
//  TrafficStatusFetcher.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-08.
//

import Foundation

class TrafficStatusFetcher {
    
    private var currentTask: URLSessionDataTask?
    typealias StatusFetchCompletion = (Result<TrafficResponse, Error>) -> ()
    
    
    func fetchData (completion: @escaping StatusFetchCompletion) {
        
        print("Hello ")
        guard let url = URL(string:"https://api.sl.se/api2/trafficsituation.json?key=\(STATUS_APIKEY)") else { print("1"); return }
        
        // Please get your own status ApiKey: https://developer.trafiklab.se/ 
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            // Reason to do in the main thread for all the stuff: the json file is small,
            // and the time it takes to parse is insignificant; of course you can do all
            // data handling in the background, and then call completion in main, but in
            // this case the difference is unnoticable, and wrapping everything in the main
            // thread minimizes any potential misstakes for enforcing completion to be run on main.
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: 999, userInfo: nil)))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(TrafficResponse.self, from: data)
                    print("model: \(model)")
                    completion(.success(model))
                    
                } catch {
                    print("failed \(error)")
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        currentTask = task
    }
    
    
    func cancelCurrentFetch() {
        currentTask?.cancel()
    }
    
}
