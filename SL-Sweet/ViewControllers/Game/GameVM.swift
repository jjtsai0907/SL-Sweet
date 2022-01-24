//
//  GameVM.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2022-01-08.
//

import UIKit

class GameVM: ObservableObject {
    
    @Published var remainingTime: Float = 3.0
    var timer: Timer?
    
    
    var amountOfPassenger = 0
    
    func AddOnePassenger() {
        amountOfPassenger += 1
        
        if remainingTime > 0 && timer == nil {
            startTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    
    @objc private func step() {
        if remainingTime > 0 {
            remainingTime -= 0.01
            print("remaining time = \(remainingTime)")
        } else {
            timer?.invalidate()
            
        }
        
    }
    
    
    func resetGame() {
        remainingTime = 3
        amountOfPassenger = 0
        timer = nil
    }
    
    
    
}
