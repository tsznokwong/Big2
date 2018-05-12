//
//  Constant.swift
//  Big2
//
//  Created by Tsznok Wong on 25/3/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

let Rank = ["3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A", "2"]
let Suit = ["Diamond", "Club", "Heart", "Spade"]
let fiveCardHand = ["Straight", "Flush", "FullHouse", "FourOfAKind", "StraightFlush"]
let Tips = ["Lose as less as possible", "Diamond 3 play first", "Try to use 5-cards hands"]
let totalInstructionPage = 16
let graphicsController = GraphicsController()
let audioController = AudioController()
let game = Game()

var gameScene = GameScene()
var ViewWidth = CGFloat()
var ViewHeight = CGFloat()
var vibrate = true
var isGameScene = false

enum Value {
    case rank, suit
}

enum Direction {
    case horizontal, vertical
    init() {
        self = .horizontal
    }
}

enum Mode {
    case easy, normal, hard
    init() {
        self = .easy
    }
}

enum error: Error {
    case invalidNumberOfPlayers
    case invalidNumberOfCards
    case invalidValue
    case invalidCurrentPlayer
    case invalidLeadingPlayer
    case invalidHandCardCombination
    case invalidCard
    case handValueSmallerThanInPool
    case numberOfCardsNotEqualToPool
    case leadingPlayerDoNotPlay
    case noHandIsDealt
}

