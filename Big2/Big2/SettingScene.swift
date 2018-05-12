//
//  settingScene.swift
//  Big2
//
//  Created by Tsznok Wong on 4/11/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

class SettingScene: SKScene {
    
    override func didMove(to view: SKView) {
        /// Called when the scene is transited to SettingScene
        
        /// Initialize setting view
        print("Moved to SettingScene")
        clearScene()
        graphicsController.initSettingView(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// Called when a touch ends
        
        for touch in touches {
            let location = touch.location(in: self)
            
            /// Confirm button pushed
            if graphicsController.Back.contains(location) {
                /// Save setting changed
                audioController.saveSetting()
                transitToMenuScene()
            } else if graphicsController.vibrateToggle.contains(location) {
                vibrate.toggle()
                graphicsController.vibrateToggle.texture = vibrate ? graphicsController.vibrateTrue : graphicsController.vibrateFalse
                audioController.vibrator()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// Called when a touch moves
        for touch in touches {
            let location = touch.location(in: self)
            let touchedSprite = atPoint(location)
            
            /// Confirm slider movement
            if touchedSprite.name == "slider" {
                /// Change volume
                let volumeBarHalfWidth = Float(graphicsController.volumeBar.frame.width) / 2
                let halfViewWidth = Float(ViewWidth / 2)
                var moveTo = Float(location.x)
                if moveTo > halfViewWidth + volumeBarHalfWidth {
                    moveTo = halfViewWidth + volumeBarHalfWidth
                } else if moveTo < halfViewWidth - volumeBarHalfWidth {
                    moveTo = halfViewWidth - volumeBarHalfWidth
                }
                touchedSprite.position.x = CGFloat(moveTo)
                audioController.changeVolume(to: (moveTo - halfViewWidth + volumeBarHalfWidth) / (volumeBarHalfWidth * 2))
            }
        }
    }
    
}



