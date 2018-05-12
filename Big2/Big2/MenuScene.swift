//
//  MenuScene.swift
//  Big2
//
//  Created by Tsznok Wong on 13/10/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
        /// Called when the scene is transited to MenuScene
        /// Initialize menu view
        
        print("Moved to Menu")
        ViewWidth = self.frame.width
        ViewHeight = self.frame.height
        game.mode = .easy

        clearScene()
        graphicsController.initMenuView(self)
        audioController.intro()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// Called when a touch ends
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedSprite = atPoint(location)
            
            if(touchedSprite.name != nil){
                /// Confirm button pushed
                
                /// How to play actions
                if touchedSprite.name! == "howToPlayButton" {
                    graphicsController.showInstructions(self)
                } else if graphicsController.howToPlay.isHidden {
                    switch touchedSprite.name! {
                    case "closeButton" :
                        graphicsController.removeInstructions(self)
                    case "NextButton" :
                        graphicsController.instructionPage += 1
                        graphicsController.updateInstructions(self)
                    case "BackButton" :
                        graphicsController.instructionPage -= 1
                        graphicsController.updateInstructions(self)
                    default: break
                    }
                }
                
                /// Start game actions
                switch touchedSprite.name! {
                case "StartButton" :
                    graphicsController.showGameModes(state: true)
                case "EasyButton" :
                    game.mode = .easy
                    transitToGameScene()
                case "NormalButton" :
                    game.mode = .normal
                    transitToGameScene()
                case "SettingButton" :
                    transitToSettingScene()
                default:
                    graphicsController.showGameModes(state: false)
                }
            } else {
                graphicsController.showGameModes(state: false)
            }
        }
    }
    


/*  DEVELOPING PROGRAM
    
    func saveGame() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(game, toFile: Game.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save game...")
        }
    }
    
    func loadGame() -> Game? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Game.ArchiveURL.path) as? Game
    }
*/

}



