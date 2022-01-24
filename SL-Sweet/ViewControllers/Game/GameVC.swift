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
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var sceneView: SKView!
    @IBOutlet weak var amountOfPassenger: UILabel!
    private var cancellables: Set<AnyCancellable> = []
    var scene: RunningScene?
    
    private var gameVM = GameVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 3)
        
        bindViewModel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scene = RunningScene(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)
    }
    
    
    @IBAction func startRunning(_ sender: Any) {
      
        gameVM.AddOnePassenger()
        amountOfPassenger.text = " \(String(gameVM.amountOfPassenger)) Passengers"
        
        print("running! \(String(gameVM.amountOfPassenger)) Passengers")
        
        if let scene = self.scene {
            scene.runPig()
        }
    }
    
    
    
    private func bindViewModel() {
        
        gameVM.$remainingTime.sink { [weak self] value in
            DispatchQueue.main.async { [self] in
                guard let self = self else { return }
                
                self.progressBar.setProgress(value / 3.0 , animated: true)
                if value < 0 {
                    //self?.runButton.isEnabled = false
                    
                    let alert = UIAlertController(title: "Great Job!", message: "Because of your hard work, \(self.gameVM.amountOfPassenger) lazy pigs can finally make it to work just on time", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.gameVM.resetGame()
                        self.amountOfPassenger.text = " \(String(self.gameVM.amountOfPassenger)) Passengers"
                        print("okay")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }.store(in: &cancellables)
     
        
    }
    
    
}
