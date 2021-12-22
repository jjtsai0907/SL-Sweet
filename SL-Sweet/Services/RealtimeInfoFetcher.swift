//
//  RealtimeInfoFetcher.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation

struct RealtimeInfoFetcher {
   
    typealias RealtimeFetchCompletion = (Result<RealtimeResponse, Error>) -> ()
    
    
    func fetchRealtimeInfo(completion: @escaping RealtimeFetchCompletion) {
        guard let url = URL(string: "https://api.sl.se/api2/realtimedeparturesv4.json?key=\(REALTIME_APIKEY)&siteid=9192&timewindow=5") else { print("url is nil"); return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
            
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 888, userInfo: nil)))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(RealtimeResponse.self, from: data)
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
