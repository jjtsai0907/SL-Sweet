//
//  GameVM.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2022-01-08.
//

import Foundation

class GameVM: ObservableObject {
    
    @Published var remainingTime: Float = 1.0
    var timer: Timer!
    
    
    var amountOfPassenger = 0
    
    func AddOnePassenger() {
        amountOfPassenger += 1
        
        if remainingTime > 0 {
            startTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    
    @objc private func step() {
        if remainingTime > 0 {
            remainingTime -= 0.1
            print("remaining time = \(remainingTime)")
        } else {
            timer.invalidate()
            
        }
        
    }
    
}
