//
//  GameScene.swift
//  Big2
//
//  Created by Tsznok Wong on 2/3/2016.
//  Copyright (c) 2016 Tsznok Wong. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var sortBy: Value = .rank               /// Sorting value
    
    func gameView() {
        /// Initialize the game view
        clearScene()
        game.initGame(self)
        graphicsController.initGameView(self)
        do {
            try game.startGame()
        } catch {}
    }

    override func didMove(to view: SKView) {
        /// Called when the scene is transited to GameScene
        
        /// Call game view
        print("Moved to GameScene")
        gameScene = self
        gameView()
        
/*  DEVELOPING PROGRAM
         
        let gameDefaults = NSUserDefaults.standardUserDefaults()
        if gameDefaults.valueForKey("Game") != nil {
            game = gameDefaults.valueForKey("Game") as! Game
        }
        if let savedGame = loadGame() {
            game = savedGame
        } else {
            game.initGame(gameScene: GameScene)
        }
*/
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// Called when a touch ends
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedSprite = atPoint(location)
            
            /// Toggle cards to be played
            if touchedSprite.isKind(of: Card.self) {
                let touchedCard = touchedSprite as! Card
                for card in game.players[0].Cards {
                    if card.name == touchedCard.name {
                        touchedCard.toggle()
                    }
                }
            }
            if touchedSprite.name != nil {
                /// Confirm button pushed
                
                if isPaused {
                    /// Actions when paused
                    func resume() {
                        isPaused = false
                        graphicsController.resume()
                    }
                    
                    switch touchedSprite.name! {
                    case "RestartButton" :
                        resume()
                        game.closeGame()
                        gameView()
                        graphicsController.reshuffling()
                    case "QuitButton" :
                        resume()
                        game.closeGame()
                        transitToMenuScene()
                    case "StartButton" :
                        resume()
                    default: break
                    }
                }
                
                /// How to play configurations
                if touchedSprite.name! == "howToPlayButton" {
                    graphicsController.showInstructions(self)
                    isPaused = true
                } else if graphicsController.howToPlay.isHidden {
                    switch touchedSprite.name! {
                    case "closeButton" :
                        graphicsController.removeInstructions(self)
                        isPaused = false
                    case "NextButton" :
                        graphicsController.instructionPage += 1
                        graphicsController.updateInstructions(self)
                    case "BackButton" :
                        graphicsController.instructionPage -= 1
                        graphicsController.updateInstructions(self)
                    default: break
                    }
                }
                
                /// Pause game
                if touchedSprite.name! == "PauseButton" {
                    isPaused = true
                    graphicsController.pause()
                }

                /// Show details
                if touchedSprite.name! == "DetailButton" {
                    graphicsController.showDetails(self)
                } else {
                    graphicsController.removeDetails(self)
                }
                
                /// Sort cards
                if touchedSprite.name! == "SortButton" {
                    if sortBy == .rank {
                        sortBy = .suit
                    } else {
                        sortBy = .rank
                    }
                    do {
                        try game.players[0].Cards.sortCards(by: sortBy)
                    } catch {}
                    game.players[0].cardVisualize()
                }
                
                /// Confirm decision
                if game.currentPlayer == 0 {
                    if touchedSprite.name! == "DealButton" {
                        do {
                            try game.placeCard(game.players[0])
                        } catch error.noHandIsDealt {
                            return
                        } catch error.leadingPlayerDoNotPlay {
                            return
                        } catch{}
                        game.endTurn()
                    } else if touchedSprite.name! == "PassButton" {
                        game.players[0].pass = true
                        do {
                            try game.placeCard(game.players[0])
                        } catch error.leadingPlayerDoNotPlay {
                            game.players[0].pass = false
                            return
                        } catch {}
                        game.players[0].pass = false
                        game.endTurn()
                    }
                }
            } else {
                graphicsController.removeDetails(self)
            }
            
        }
    }
    

/*  DEVELOPING PROGRAM
     
    func loadGameView() {
        gameView()
        do {
            try game.computerMove()
        } catch {}
        if game.checkEndGame() {
            transitToGameoverScene()
            return
        }
    }
*/
}



