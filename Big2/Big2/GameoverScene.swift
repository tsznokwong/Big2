//
//  GameoverScene.swift
//  Big2
//
//  Created by Tsznok Wong on 13/10/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

class GameoverScene: SKScene {
    
    func saveProgress() {
        /// Save players' scores
        var scores = [Int]()
        scores.reserveCapacity(4)
        for player in game.players {
            scores.append(player.score)
        }
        let scoreValue = UserDefaults.standard
        scoreValue.set(scores, forKey: "scores")
        scoreValue.synchronize()
    }
    
    override func didMove(to view: SKView) {
        /// Called when the scene is transited to GameScene
        
        /// Initialize game over view
        print("Moved to GameoverScene")
        clearScene()
        graphicsController.initGameoverView(self)
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// Called when a touch ends
        for touch in touches {
            let location = touch.location(in: self)

            /// Confirm button pushed
            saveProgress()
            if graphicsController.Next.contains(location) {
                transitToGameScene()
            }
            if graphicsController.Back.contains(location) {
                transitToMenuScene()
            }
        }
    }

}



