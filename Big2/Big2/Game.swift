//
//  game.swift
//  Big2
//
//  Created by Tsznok Wong on 4/3/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

class Game {                             /* DEVELOPING    inherit NSObject, NSCoding */
    
    var deck = Deck()                       /// Deck of the game
    var pool = Pool()                       /// Pool of the game
    var players = [Computer]()              /// Players of the game
    var currentPlayer: Int? = nil           /// Current player pointer
    var leadingPlayer: Int? = nil           /// Leading player pointer
    var mode = Mode()                       /// Game mode
    var endGame: Bool = false               /// End game flag
    var move: Int = 0                       /// Count moves
    var moves = [Hand?]()                   /// Last 3 moves
    var lastHand: Hand?                     /// Last hand of game
    
    init() {
        /// Initialize players
        players.append(Player(name: "Player"))
        for computer in 1 ... 3 {
            players.append(Computer(name: "Computer\(computer)"))
        }
        var iterator = 1.0
        for player in players {
            let x = CGFloat(pow(iterator, 3.0) + 3 * pow(iterator, 2.0) + 3 * iterator + 2).truncatingRemainder(dividingBy: 4)
            let y = CGFloat(pow(iterator, 3.0) + 2 * pow(iterator, 2.0) + 1).truncatingRemainder(dividingBy: 4)
            player.initPlayer(CGPoint(x: ViewWidth * x / 2, y: ViewHeight * y / 2))
            player.direction = iterator.truncatingRemainder(dividingBy: 2) == 0 ? .vertical : .horizontal
            iterator += 1
        }
        var scores = [Int]()
        let scoreValue = UserDefaults.standard
        if scoreValue.value(forKey: "scores") != nil {
            scores = scoreValue.value(forKey: "scores") as! [Int]
            for iterator in 0 ..< 4 {
                players[iterator].score = scores[iterator]
            }
        }
        
        /// Initialize moves
        moves.reserveCapacity(3)
        for _ in 0 ..< 3 {
            moves.append(nil)
        }
    }
    

    func initGame(_ scene: GameScene) {
        /// Initialize a game
        print("Initialize Game")
        gameScene = scene
        print("Number of Cards in Deck = \(deck.Cards.count)")
        
        for card in deck.Cards {
            card.removeAllActions()
            card.removeFromParent()
            card.initCardSprite()
            gameScene.addChild(card)
        }
 
        for player in players {
            player.mode = mode
        }
        endGame = false
        pool = Pool()
        lastHand = nil
        currentPlayer = nil
        leadingPlayer = nil
        move = 0
        moves.removeAll(keepingCapacity: true)
        for _ in 0 ..< 3 {
            moves.append(nil)
        }
    }
    
    func startGame() throws {
        /// Throw: invalid number of players

        /// Generate Tips
        let tips = SKAction.run({
            () in graphicsController.randomTips()
        })
        let delay = SKAction.wait(forDuration: 30)
        gameScene.run(SKAction.repeatForever(SKAction.sequence([delay, tips])))
        
        /// Card shuffling
        deck.shuffling()
        guard players.count == 4 else {
            print("Error: Numbers of players isn't 4 (\(players.count)).")
            throw error.invalidNumberOfPlayers
        }
        
        func distributeNext(_ playerIndex: Int) {
            if deck.Cards.count == 0 {
                
                /// Check disadvantagedness
                for player in players {
                    var count = 0
                    for card in player.Cards {
                        if Rank.index(of: card.rank)! >= Rank.index(of: "J")! {
                            count += 1
                        }
                    }
                    if count < 3 {
                        closeGame()
                        gameScene.gameView()
                        graphicsController.reshuffling()
                        return
                    }
                }
                
                /// Search first player
                for player in players {
                    for card in player.Cards {
                        if card.rank == "3" && card.suit == "Diamond" {
                            currentPlayer = players.index(of: player)!
                            break
                        }
                    }
                }
                print("First Player: ", currentPlayer!)
                leadingPlayer = currentPlayer
                
                /// Sort players' cards
                for player in players {
                    do {
                        try player.Cards.sortCards(by: Value.rank)
                    } catch {}
                    player.cardVisualize()
                }
                
                /// Visualize pointer
                graphicsController.gameStart()
                graphicsController.updateRedDot()
                
                /// Initiate first play
                do {
                    try computerMove()
                } catch {}
                return
            }
            
            /// Distribute next card
            let distribute = SKAction.run({
                () in
                game.players[playerIndex].Cards.append(game.deck.Cards.last!)
                game.deck.Cards.removeLast()
                game.players[playerIndex].cardVisualize()
                distributeNext((playerIndex + 1) % 4)
                audioController.dealCard()
            })
            gameScene.run(SKAction.sequence([SKAction.wait(forDuration: 0.05), distribute]))
            
        }
        
        /// Card distribution
        distributeNext(0)
    }
    
    func placeCard(_ player: Computer) throws {
        /// Throw: leading player do not play
        ///        no hand is dealt
        
        func checkOnHand(_ hand: Hand, player: Computer) throws {
            /// Throw: invalid card
            
            /// Check hand placed is on player’s hand
            for card in hand.Cards {
                if player.Cards.index(of: card) == nil {
                    print("Error: Handcard is not in hand.")
                    throw error.invalidCard
                }
            }
        }
        
        func removeOnHand(_ hand: Hand, player: Computer) {
            /// Remove cards in player’s hand
            for card in hand.Cards {
                do {
                    try player.Cards.removeCard(card)
                } catch {}
            }
        }
        
        defer {
            /// Visualize cards
            player.cardVisualize()
        }
        
        /// Get player’s cards for deal
        var hand = player.dealCards(moves, prevention: players[(currentPlayer! + 1) % 4].Cards.count == 1)
        if hand != nil {
            /// Check is hand valid
            do {
                try hand!.Cards.sortCards(by: Value.rank)
                try checkOnHand(hand!, player: player)
                try pool.checkHand(&hand!, leading: leadingPlayer == currentPlayer)
            } catch error.invalidHandCardCombination {
                hand = nil
            } catch error.invalidCard {
                hand = nil
            } catch {
                if leadingPlayer != currentPlayer {
                    hand = nil
                }
            }
        }
        
        if hand != nil {
            /// Accept valid hand
            removeOnHand(hand!, player: player)
            hand?.playedBy = player.playerName
            pool.Hands.append(hand!)
            print("\(player.playerName) has played")
            hand?.printHand()
            moves.removeFirst()
            moves.append(hand)
            for _ in 1 ... hand!.Cards.count {
                audioController.dealCard()
            }
            hand?.handVisualize(CGPoint(x: ViewWidth / 2, y: ViewHeight * 4 / 7), zPosition: CGFloat(move * 2 + 10), duration: 0.4)
            leadingPlayer = currentPlayer
            return
        } else if leadingPlayer == currentPlayer {
            print("Error: LeadingPlayer does not play a card")
            throw error.leadingPlayerDoNotPlay
        } else {
            /// Check is player pass
            if player.pass == false {
                if player.playerName == "Player" {
                    graphicsController.alertPlayCardCorrectly()
                    print("Error: No Hand Is Dealt (player: \(player.playerName))")
                    throw error.noHandIsDealt
                } else {
                    moves.removeFirst()
                    moves.append(hand)
                    print("\(player.playerName) pass")
                }
            } else {
                print("Player pass")
                moves.removeFirst()
                moves.append(hand)
            }
        }
    }
    
    func endTurn() {
        /// End turn
        print("pool top by \(pool.Hands.last!.playedBy)")
        pool.Hands.last?.Cards.printCards()
        if pool.Hands.last?.powerValue != nil {
            print("Five Card Hand Power: \((pool.Hands.last?.powerValue)!)")
        }
        
        /// Check end game
        if checkEndGame() {
            print("End Game")
            gameScene.transitToGameoverScene()
            return
        }
        
        /// Initiate next turn
        currentPlayer! += 1
        currentPlayer! %= 4
        move += 1
        graphicsController.updateRedDot()
        do {
            try computerMove()
        } catch {}
    }
    
    func computerMove() throws {
        /// Throw: invalid current player
        ///        invalid leading player
        
        guard currentPlayer != nil else {
            print("Error: CurrentPlayer is nil.")
            throw error.invalidCurrentPlayer
        }
        guard leadingPlayer != nil else {
            print("Error: LeadingPlayer is nil.")
            throw error.invalidLeadingPlayer
        }
        
        /// Toggle player’s buttons
        if endGame == true || currentPlayer == 0 {
            graphicsController.hidePlayerButtons(state: false)
            audioController.vibrator()
        } else {
            graphicsController.hidePlayerButtons(state: true)
            
            /// Delay & place card
            let place = SKAction.run({
                () in
                do {
                    try game.placeCard(game.players[game.currentPlayer!])
                } catch {}
                game.endTurn()
            })
            gameScene.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), place]))
        }
        
    }
    
    func checkEndGame() -> Bool {
        /// Return: is game ended
        
        /// Check end game
        for player in players {
            if player.Cards.count == 0 {
                endGame = true
                closeGame()
                return true
            }
        }
        return false
    }
    
    func closeGame() {
        /// Mark last hand
        lastHand = Hand()
        if pool.Hands.count > 0 {
            lastHand?.Cards.append(contentsOf: pool.Hands.last!.Cards)
            lastHand?.playedBy = (pool.Hands.last?.playedBy)!

        }
        
        /// Close game
        do {
            try deck.returnCards(pool, players: players)
        } catch error.invalidNumberOfCards {
            deck = Deck()
        } catch {}
        
/*  DEVELOPING PROGRAM
         
        let gameDefaults = UserDefaults.standard
        gameDefaults.setValue(self, forKey: "game")
        gameDefaults.synchronize()
*/
    }
    
/*  DEVELOPING PROGRAM
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Game")
     
    struct PropertyKey {
        static let deckKey = "Deck"
        static let poolKey = "Pool"
        static let playersKey = "Players"
        static let currentPlayerKey = "CurrentPlayer"
        static let leadingPlayerKey = "LeadingPlayer"
        static let endGameKey = "EndGame"
        static let moveKey = "Move"
        static let movesKey = "Moves"
    }
     
    init?(deck: Deck, pool: Pool, players: [Computer], currentPlayer: Int?, leadingPlayer: Int?, endGame: Bool, move: Int) {
        self.deck = deck
        self.pool = pool
        self.players = players
        self.currentPlayer = currentPlayer
        self.leadingPlayer = leadingPlayer
        self.endGame = endGame
        self.move = move
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let deck = aDecoder.decodeObject(forKey: PropertyKey.deckKey) as! Deck
        let pool = aDecoder.decodeObjectForKey(PropertyKey.poolKey) as! Pool
        let players = aDecoder.decodeObjectForKey(PropertyKey.playersKey) as! [Computer]
        let currentPlayer = aDecoder.decodeObject(forKey: PropertyKey.currentPlayerKey) as! Int?
        let leadingPlayer = aDecoder.decodeObject(forKey: PropertyKey.leadingPlayerKey) as! Int?
        let endGame = aDecoder.decodeBool(forKey: PropertyKey.endGameKey)
        let move = aDecoder.decodeInteger(forKey: PropertyKey.moveKey)
        self.init(deck: deck, pool: pool, players: players, currentPlayer: currentPlayer, leadingPlayer: leadingPlayer, endGame: endGame, move: move)
     }
     
     func encode(with aCoder: NSCoder) {
        aCoder.encode(deck, forKey: PropertyKey.deckKey)
        aCoder.encodeObject(pool, forKey: PropertyKey.poolKey)
        aCoder.encodeObject(players, forKey: PropertyKey.playersKey)
        aCoder.encode(currentPlayer, forKey: PropertyKey.currentPlayerKey)
        aCoder.encode(leadingPlayer, forKey: PropertyKey.leadingPlayerKey)
        aCoder.encode(endGame, forKey: PropertyKey.endGameKey)
        aCoder.encode(move, forKey: PropertyKey.moveKey)
     }
*/
    
}



