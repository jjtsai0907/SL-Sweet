//
//  RealtimeInfoFetcher.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2021-12-22.
//

import Foundation

struct RealtimeInfoFetcher {
   
    typealias RealtimeFetchCompletion = (Result<RealtimeInfo, Error>) -> ()
    
    
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
                let model = try JSONDecoder().decode(RealtimeInfo.self, from: data)
                print("model: \(model.ResponseData.Buses)")
                completion(.success(model))
                
            } catch {
                print("failed \(error)")
                completion(.failure(error))
            }
            
        }
        
        task.resume()
        
    }
    
    
    func searchRealtimeInfo(searchInput: String, complition: @escaping RealtimeFetchCompletion) {
        // Slussen: 9192; Skuru Skola: 4027; Odenplan: 9117
        guard let url = URL(string: "https://api.sl.se/api2/realtimedeparturesv4.json?key=\(REALTIME_APIKEY)&siteid=\(searchInput)&timewindow=5") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    complition(.failure(error))
                    print("Search fails, try another number")
                    return
                }
            }
            
            guard let data = data else {
                complition(.failure(NSError(domain: "", code: 777, userInfo: nil)))
                print("Search fails, try another number")
                return }
            
            do {
                let model = try JSONDecoder().decode(RealtimeInfo.self, from: data)
                print("searchRealtimeInfo(): \(model.ResponseData.Metros) \(model.ResponseData.Buses)")
                complition(.success(model))
            } catch {
                print("searchRealtimeInfo(): failed \(error)")
                complition(.failure(error))
            }
            
            
            
        }
        
        task.resume()
        
        
    }
    
    
    
}
