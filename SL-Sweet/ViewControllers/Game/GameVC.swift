//
//  GameVC.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2022-01-08.
//

import UIKit
import SpriteKit
import Combine

class GameVC: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var sceneView: SKView!
    @IBOutlet weak var amountOfPassenger: UILabel!
    private var cancellables: Set<AnyCancellable> = []
    var scene: RunningScene?
    
    private var gameVM = GameVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        progressBar.setProgress(1.0, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scene = RunningScene(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)
    }
    
    
    @IBAction func startRunning(_ sender: Any) {
        //gameVM.startTimer()
        //progressBar.progress =
        gameVM.AddOnePassenger()
        amountOfPassenger.text = " \(String(gameVM.amountOfPassenger)) Passengers"
        
        print("runing! \(String(gameVM.amountOfPassenger)) Passengers")
        
        if let scene = self.scene {
            scene.runPig()
        }
    }
    
    
    
    private func bindViewModel() {
        
        gameVM.$remainingTime.sink { [weak self] value in
            self?.progressBar.setProgress(value, animated: true)
        }.store(in: &cancellables)
     
        
    }
}