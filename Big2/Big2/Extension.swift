//
//  Extension.swift
//  Big2
//
//  Created by Tsznok Wong on 3/3/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit


extension Bool {
    
    mutating func toggle() {
        /// Toggle the value of Boolean expression and return its value.
        self = !self
    }
}

extension Array where Element: Card {
    
    fileprivate func isOrderByRank(_ card1: Card, card2: Card) -> Bool {
        /// Return: comparing of card by rank
        
        return card1 < card2
    }
    
    fileprivate func isOrderBySuit(_ card1: Card, card2: Card) -> Bool {
        /// Return: comparing of card by suit
        
        if Suit.index(of: card1.suit)! < Suit.index(of: card2.suit)! {
            return true
        }
        return Rank.index(of: card1.rank)! < Rank.index(of: card2.rank)! && Suit.index(of: card1.suit)! == Suit.index(of: card2.suit)!
    }

    internal mutating func sortCards(by value: Value) throws {
        /// Throw: invalid value
        
        guard value == Value.rank || value == Value.suit else {
            print("Error: Unable to sort by unknown value (\(value)).")
            throw error.invalidValue
        }
        if self.count == 0 {
            return 
        }
        
        /// Sort cards according value
        if value == Value.rank {
            self.sort(by: isOrderByRank)
        } else {
            self.sort(by: isOrderBySuit)
        }
    }

    internal mutating func removeCard(_ element: Array.Iterator.Element) throws {
        /// Throws: InvalidCard

        let index = self.index(of: element)
        guard index != nil else {
            print("Error: Remove invalid card.")
            throw error.invalidCard
        }
        
        /// Remove card
        self.remove(at: index!)
    }
    
    internal func printCards() {
        /// Print array of card
        for card in self {
            card.printCard()
        }
    }
    /// Print array of card
}

extension SKScene {
    
    func clearScene() {
        /// Clear scene
        audioController.Player.removeFromParent()
        graphicsController.background.removeFromParent()
        self.removeAllActions()
        self.removeAllChildren()
        self.addChild(graphicsController.background)
        self.addChild(audioController.Player)
    }

    func transitToGameoverScene() {
        /// Transit the current scene to GameoverScene
        let gameoverScene = GameoverScene(size: self.size)
        isGameScene = false
        clearScene()
        self.view?.presentScene(gameoverScene)
    }

    func transitToMenuScene() {
        /// Transit the current scene to MenuScene
        let menuScene = MenuScene(size: self.size)
        isGameScene = false
        clearScene()
        self.view?.presentScene(menuScene)
    }
    
    func transitToGameScene() {
        /// Transit the current scene to GameScene
        let gameScene = GameScene(size: self.size)
        isGameScene = true
        clearScene()
        self.view?.presentScene(gameScene)
    }
    
    func transitToSettingScene() {
        /// Transit the current scene to SettingScene
        let settingScene = SettingScene(size: self.size)
        isGameScene = false
        clearScene()
        self.view?.presentScene(settingScene)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// Called when a touch begins
        for touch in touches {
            let location = touch.location(in: self)
            let touchedSprite = atPoint(location)
            
            /// Button animation when tapped
            if touchedSprite.isKind(of: Button.self) {
                let touchedButton = touchedSprite as! Button
                touchedButton.tap()
            }
            
            /// Pause from inactive
            if speed == 0.0 {
                isPaused = true
                speed = 1.0
            }
            
        }
    }
    
}

extension SKNode {
    
    func addChildren(_ Nodes: [SKNode]) {
        /// Add array of SKNode as child
        for node in Nodes {
            addChild(node)
        }
    }
    
}
