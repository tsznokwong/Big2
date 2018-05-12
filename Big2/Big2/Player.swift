//
//  player.swift
//  Big2
//
//  Created by Tsznok Wong on 3/3/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

class Computer: Equatable {
    
    var Cards = [Card]()                        /// Cards of player
    var playerName = String()                   /// Name of player
    var mode = Mode()                           /// Mode of AI
    var position = CGPoint()                    /// Position of player
    var direction = Direction()                 /// Direction of cards
    var scoreLabel = SKOutlinedLabelNode()      /// Score label of player
    var score = Int()                           /// Score of player
    var changeScore: Int = 0                    /// Change of score of player
    var pass: Bool = false                      /// Is player pass
    
    init(name: String) {
        /// Initialize computer
        Cards.reserveCapacity(13)
        playerName = name
        score = 0
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontName =  defaultFontName
        scoreLabel.fontSize = defaultFontSize + 10
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 99
        scoreLabel.borderWidth = 3
    }
    
    internal func initPlayer(_ position: CGPoint) {
        /// Initialize computer for start of game
        do {
            try Cards.sortCards(by: Value.rank)
        } catch {}
        self.position = position
    }
    
    internal func printCards() {
        /// Print cards in computer’s hand
        print(playerName)
        Cards.printCards()
    }

    internal func dealCards(_ moves: [Hand?], prevention: Bool) -> Hand? {
        /// Return: hand to be played
        
        var previous: Hand? = nil
        
        func getSameRankCards(greaterThan fix: Card = Card(rank: "3", suit: "Diamond"),
                              numberOfCard max: Int? = nil, allCards: Bool = false) -> [Card]? {
            /// Return: array of cards having same rank
            
            var cards = [Card]()
            var currentRank = Cards.first?.rank
            var count = 0
            for card in Cards {
                if currentRank == card.rank && (max == nil || allCards || count < max!) {
                    count += 1
                    cards.append(card)
                } else {
                    if max == nil || (count == max && cards.last! >= fix) {
                        return cards
                    }
                    currentRank = card.rank
                    count = 1
                    cards.removeAll()
                    cards.append(card)
                }
            }
            if max == nil || (count == max && cards.last! >= fix) {
                return cards
            }
            return nil
        }
        
        func searchFiveCardHand(greaterThan fix: Hand? = nil) -> Hand? {
            /// Return: 5-cards hand available
            
            var cardTable = [[Bool]]()
            var rankCount = [Int]()
            var suitCount = [Int]()
            let powerValue = fix != nil ? fiveCardHand.index(of: (fix?.powerValue)!) : 0
            
            print("Searching 5-cards hand")
            
            func checkFullHouse() -> Hand? {
                /// Return: full house available
                let fullHouseValue = fiveCardHand.index(of: "FullHouse")!
                if powerValue! <= fullHouseValue {
                    let hand = Hand()
                    let triple = powerValue == fullHouseValue ? getSameRankCards(greaterThan: (fix?.comparingCard)!, numberOfCard: 3, allCards: true) : getSameRankCards(numberOfCard: 3, allCards: true)
                    var pair = getSameRankCards(numberOfCard: 2, allCards: true)  ?? getSameRankCards(numberOfCard: 2)
                    let tripleRank = triple?.first?.rank
                    var pairRank = pair?.first?.rank
                    if triple != nil && pair != nil && pairRank == tripleRank {
                        let card = Card(rank: Rank[(Rank.index(of: pairRank!)! + 1) % 13], suit: "Diamond")
                        pair = getSameRankCards(greaterThan: card, numberOfCard: 2, allCards: true) ?? getSameRankCards(greaterThan: card, numberOfCard: 2)
                    }
                    pairRank = pair?.first?.rank
                    if triple != nil && pair != nil && pairRank != tripleRank {
                        hand.Cards.append(contentsOf: triple!)
                        hand.Cards.append(contentsOf: pair!)
                        return hand
                    }
                }
                return nil
            }
            
            func checkFourOfAKind() -> Hand? {
                /// Return: four of a kind available
                
                let quadValue = fiveCardHand.index(of: "FourOfAKind")!
                if powerValue! <= quadValue {
                    let hand = Hand()
                    let quad = powerValue == quadValue ? getSameRankCards(greaterThan: (fix?.comparingCard)!, numberOfCard: 4, allCards: true) : getSameRankCards(numberOfCard: 4, allCards: true)
                    var single = getSameRankCards(numberOfCard: 1, allCards: true) ?? getSameRankCards(numberOfCard: 1)
                    let quadRank = quad?.first?.rank
                    var singleRank = single?.first?.rank
                    if quad != nil && singleRank == quadRank {
                        let card = Card(rank: Rank[(Rank.index(of: singleRank!)! + 1) % 13], suit: "Diamond")
                        single = getSameRankCards(greaterThan: card, numberOfCard: 1, allCards: true) ?? getSameRankCards(greaterThan: card, numberOfCard: 1)
                    }
                    singleRank = single?.first?.rank
                    if quad != nil && single != nil && singleRank != quadRank {
                        hand.Cards.append(contentsOf: quad!)
                        hand.Cards.append(contentsOf: single!)
                        return hand
                    }
                }
                return nil
            }
            
            func checkStraightFlush() -> Hand? {
                /// Return: straight flush available
                
                let straightFlushValue = fiveCardHand.index(of: "StraightFlush")!
                if powerValue! <= straightFlushValue {
                    var rank = Rank.index(of: "A")!
                    let hand = Hand()
                    for _ in 0 ..< 10 {
                        if rankCount[rank] > 0 {
                            for suit in 0 ..< 4 {
                                if cardTable[rank][suit] {
                                    for card in Cards {
                                        if Rank[rank] == card.rank && Suit[suit] == card.suit {
                                            hand.Cards.append(card)
                                            break
                                        }
                                    }
                                    for iterator in 1 ... 4 {
                                        if cardTable[(rank + iterator) % 13][suit] {
                                            for card in Cards {
                                                if Rank[(rank + iterator) % 13] == card.rank && Suit[suit] == card.suit {
                                                    hand.Cards.append(card)
                                                    break
                                                }
                                            }
                                        } else {
                                            hand.Cards.removeAll()
                                        }
                                    }
                                    if hand.Cards.count == 5 && (powerValue! < straightFlushValue || previous == nil || hand.Cards.last! > (previous?.comparingCard)!) {
                                        return hand
                                    }
                                    hand.Cards.removeAll()
                                }
                            }
                        }
                        rank = (rank + 1) % 13
                    }
                }
                return nil
            }
            
            func checkStraight() -> Hand? {
                /// Return: straight available
                
                let straightValue = fiveCardHand.index(of: "Straight")!
                if powerValue! <= straightValue {
                    var rank = Rank.index(of: "A")!
                    let hand = Hand()
                    for _ in 0 ..< 10 {
                        if rankCount[rank] > 0 {
                            for suit in 0 ..< 4 {
                                if cardTable[rank][suit] {
                                    for card in Cards {
                                        if Rank[rank] == card.rank && Suit[suit] == card.suit {
                                            hand.Cards.append(card)
                                            break
                                        }
                                    }
                                    if hand.Cards.count == 5 {
                                        if previous != nil && hand.Cards.last! < (previous?.comparingCard)! {
                                            hand.Cards.removeFirst()
                                            continue
                                        }
                                        
                                        let sample = hand.Cards.first!.suit
                                        var count = 0
                                        for card in hand.Cards {
                                            if card.suit == sample {
                                                count += 1
                                            }
                                        }
                                        if count != 5 {
                                            return hand
                                        }
                                    }
                                    break
                                }
                            }
                        } else {
                            hand.Cards.removeAll()
                        }
                        rank = (rank + 1) % 13
                    }
                }
                return nil
            }
            
            func checkFlush() -> Hand? {
                /// Return: flush available
                func checkContinuous(_ cards: [Card]) throws -> Bool {
                    /// Throw: invalid number of cards
                    /// Return: is the cards in continuous order
                    
                    guard cards.count >= 1 else {
                        print("Error: Invalid number of cards (\(cards.count)).")
                        throw error.invalidNumberOfCards
                    }
                    
                    var valid = true
                    for iterator in 1 ..< cards.count {
                        if Rank.index(of: cards[iterator - 1].rank)! + 1 != Rank.index(of: cards[iterator].rank)! {
                            valid = false
                        }
                    }
                    return valid
                }
                
                func checkStraight(_ hand: Hand) throws -> Bool {
                    /// Throw: invalid number of cards
                    /// Return: is the hand a straight
                    
                    let cards = hand.Cards
                    guard cards.count == 5 else {
                        print("Error: Number of cards not equal to 5 (\(cards.count)).")
                        throw error.invalidNumberOfCards
                    }
                    
                    var valid = try checkContinuous(cards)
                    if valid && cards.first!.rank == "J" {
                        valid = false
                    } else if !valid {
                        var tmpCards = [Card]()
                        tmpCards.append(contentsOf: cards.dropLast(2))
                        valid = try checkContinuous(tmpCards)
                        if valid && cards.first?.rank == "3" && cards.last?.rank == "2" {
                            if cards[3].rank == "6"  {
                                hand.comparingCard = cards[3]
                                valid = true
                            } else if cards[3].rank == "A"{
                                hand.comparingCard = cards[2]
                                valid = true
                            } else {
                                valid = false
                            }
                        } else {
                            valid = false
                        }
                    } else {
                        hand.comparingCard = cards.last!
                    }
                    return valid
                }
                
                let flushValue = fiveCardHand.index(of: "Flush")!
                if powerValue! <= flushValue {
                    for suit in 0 ..< 4 {
                        let hand = Hand()
                        var max = powerValue == flushValue ? (previous?.comparingCard)! : Card(rank: "3", suit: "Diamond")
                        for card in Cards {
                            if card.suit == Suit[suit] && card > max {
                                hand.Cards.append(card)
                                max = card
                                break
                            }
                        }
                        if suitCount[suit] > 4 && max != previous?.comparingCard ?? Card(rank: "3", suit: "Diamond") {
                            for card in Cards {
                                if card.suit == Suit[suit] && card != max {
                                    hand.Cards.append(card)
                                    if hand.Cards.count == 5 {
                                        var straightFlush = true
                                        do {
                                            try straightFlush = checkStraight(hand)
                                        } catch {}
                                        if !straightFlush {
                                            return hand
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                return nil
            }
            
            /// Manage data required
            for _ in 0 ..< 13 {
                var tmp = [Bool]()
                for _ in 0 ..< 4 {
                    tmp.append(false)
                }
                cardTable.append(tmp)
                rankCount.append(0)
            }
            for _ in 0 ..< 4 {
                suitCount.append(0)
            }
            for card in Cards {
                let rank = Rank.index(of: card.rank)!
                let suit = Suit.index(of: card.suit)!
                cardTable[rank][suit] = true
                rankCount[rank] += 1
                suitCount[suit] += 1
            }

            /// Check 5-cards hand availability
            if let straight = checkStraight() {
                return straight
            }
            
            if let flush = checkFlush() {
                return flush
            }
            
            if let fullHouse = checkFullHouse() {
                return fullHouse
            }
            
            if let quadHand = checkFourOfAKind() {
                return quadHand
            }
            
            if let straightFlush = checkStraightFlush() {
                return straightFlush
            }
            

            return nil
        }
        
        func easyAI() -> Hand? {
            /// Return: hand using easy AI
            
            let hand = Hand()
            print("Using Easy AI")
            /// Prevention required action
            if prevention {
                if previous == nil {
                    let cards = getSameRankCards(numberOfCard: 3) ?? getSameRankCards(numberOfCard: 2)
                    if cards != nil {
                        hand.Cards.append(contentsOf: cards!)
                        return hand
                    }
                    hand.Cards.append(Cards.last!)
                    return hand
                } else if previous?.Cards.count == 1{
                    hand.Cards.append(Cards.last!)
                    return hand
                }
            }
            
            /// Leading action
            if previous == nil {
                let cards = getSameRankCards()
                hand.Cards.append(contentsOf: cards!)
                if cards?.count == 4 {
                    hand.Cards.removeLast()
                }
                return hand
            }
            
            /// General action
            let cards = getSameRankCards(greaterThan: (previous?.Cards.last)!, numberOfCard: (previous?.Cards.count)!, allCards: true) ?? getSameRankCards(greaterThan: (previous?.Cards.last)!, numberOfCard: (previous?.Cards.count)!)
            if cards != nil {
                hand.Cards.append(contentsOf: cards!)
                return hand
            }
            return nil
        }
        
        if Cards.count == 0 {
            return nil
        }
        
        /// Get pool top hand
        for iterator in 0 ..< 3 {
            if moves[iterator] != nil {
                previous = moves[iterator]
            }
        }
        
        switch mode {
        case .normal :              /// Normal AI
            print("Using Normal AI")
            if previous == nil || previous?.Cards.count == 5 {
                let fiveCardHand = searchFiveCardHand(greaterThan: previous)
                if fiveCardHand != nil {
                    return fiveCardHand
                }
            }
            return easyAI()
            
        case .easy :                /// Easy AI
            return easyAI()
        default: break
        }
        return nil
    }
   
    internal func cardVisualize() {
        /// Visualize cards
        var iterator = 10
        for card in Cards {
            card.run(SKAction.resize(toWidth: ViewWidth / 10, height: ViewWidth / 10 / 272 * 381, duration: 0.3))
            card.zPosition = CGFloat(iterator + 1)
            iterator += 1
        }
        switch direction {
        case .horizontal:
            var x = ViewWidth / 2 - CGFloat(Cards.count - 1) / 2 * ViewWidth / 30
            for card in Cards {
                card.run(SKAction.rotate(toAngle: CGFloat(degreeToRadian(degree: 180)), duration: 0.3))
                card.run(SKAction.move(to: CGPoint(x: x, y: position.y), duration: 0.3))
                x += ViewWidth / 30
            }
        break
        case .vertical:
            var y = ViewHeight / 2 - CGFloat(Cards.count - 1) / 2 * ViewHeight / 20
            for card in Cards {
                card.run(SKAction.rotate(toAngle: CGFloat(degreeToRadian(degree: 90 * (position.x < ViewWidth ? -1 : 1))), duration: 0.3))
                card.run(SKAction.move(to: CGPoint(x: position.x, y: y), duration: 0.3))
                y += ViewHeight / 20
            }
        break
        }
    }
}

class Player: Computer {
    
    override func initPlayer(_ position: CGPoint) {
        /// Initialize player for start of game
        for card in Cards {
            card.flip()
        }
        self.position = position
    }
    
    override func dealCards(_ moves: [Hand?], prevention: Bool) -> Hand? {
        /// Return: hand to be played
        
        if pass {
            return nil
        }
        
        /// Get cards to be played
        let deal = Hand()
        for card in Cards {
            if card.deal {
                deal.Cards.append(card)
            }
        }
        return deal
    }
 
    override func cardVisualize() {
        /// Visualize cards
        var iterator = 10
        var x = ViewWidth / 2 - CGFloat(Cards.count - 1) / 2 * ViewWidth / 20
        for card in Cards {
            card.run(SKAction.rotate(toAngle: 0, duration: 0.3))
            if !card.faceup {
                card.flip()
            }
            card.run(SKAction.move(to: CGPoint(x: x, y: 0), duration: 0.3))
            card.zPosition = CGFloat(iterator + 1)
            card.deal = false 
            x += ViewWidth / 20
            iterator += 1
        }
    }
}

