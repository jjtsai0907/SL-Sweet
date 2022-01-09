//
//  RunningScene.swift
//  SL-Sweet
//
//  Created by Jia-Jiuan Tsai on 2022-01-09.
//

import UIKit
import SpriteKit

class RunningScene: SKScene {
    
    // frames:
    var runningFrames: [SKTexture]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        //self.backgroundColor = UIColor.red
        // place holder for frames
        var frames: [SKTexture] = []
        
        let pigAtlas = SKTextureAtlas(named: "pig")
        
        for index in 1...6 {
            let textureName = "frame_\(index)"
            let texture = pigAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.runningFrames = frames
        
    }
    
    func runPig() {
        let texture = self.runningFrames![0]
        let pig = SKSpriteNode(texture: texture)
        pig.size = CGSize(width: 140, height: 140)
        
        pig.position = CGPoint(x: CGFloat(20), y: CGFloat(50))
        
        self.addChild(pig)
        pig.run(SKAction.repeatForever(SKAction.animate(with: self.runningFrames!, timePerFrame: 0.05, resize: false, restore: true)))
        
        let distanceToCover = self.frame.size.width + pig.size.width
        let time = TimeInterval(abs(distanceToCover / 140))
        let moveAction = SKAction.moveBy(x: distanceToCover, y: 0, duration: time)
        
        let removeAction = SKAction.run {
            pig.removeAllActions()
            pig.removeFromParent()
        }
        
        let allAction = SKAction.sequence([moveAction, removeAction])
        pig.run(allAction)
    }
    
    
    
    
}
