//
//  Deck.swift
//  Big2
//
//  Created by Tsznok Wong on 14/5/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation

class Deck {                            /* DEVELOPING    inherit NSObject, NSCoding */
    
    var Cards = [Card]()                    /// Cards in deck

    init() {
        /// Initialize a deck
        Cards.reserveCapacity(52)
        for count in 0 ..< 52 {
            let card = Card(rank: Rank[count / 4], suit: Suit[count % 4])
            Cards.append(card)
        }
    }
        

    internal func printDeck() {
        /// Print deck
        print("Deck")
        Cards.printCards()
    }
    
    internal func shuffling() {
        /// Random shuffling by overhand and riffle
        let to = randomInt(min: 6, max: 12)
        for _ in 1 ... to {
            let mode = randomInt(min: 0, max: 1)
            switch mode {
            case 0:             /// Overhand
                for _ in 1 ... 3 {
                    let first = randomInt(min: 0, max: 51)
                    let second = randomInt(min: first, max: 51)
                    let tmpDeck = Cards[first ... second]
                    Cards.removeSubrange(first ... second)
                    Cards += tmpDeck
                }

            case 1:             /// Riffle
                let mid = randomInt(min: 20, max: 30)
                var firstDeck = Cards[0 ... mid]
                var secondDeck = Cards[mid + 1 ... 51]
                Cards.removeAll(keepingCapacity: true)
                
                while firstDeck.isEmpty == false || secondDeck.isEmpty == false {
                    if firstDeck.isEmpty == false {
                        let putCard = randomInt(min: 1, max: min(firstDeck.count, 3))
                        Cards += firstDeck[0 ..< putCard]
                        firstDeck.removeSubrange(0 ..< putCard)
                    }
                    if secondDeck.isEmpty == false {
                        let putCard = randomInt(min: 1, max: min(secondDeck.count, 3))
                        Cards += secondDeck[mid + 1 ..< mid + putCard + 1]
                        secondDeck.removeSubrange(mid + 1 ..< mid + putCard + 1)
                    }
                }
            default: break
            }
        }
    }
    
    func returnCards(_ pool: Pool?, players: [Computer]) throws {
        /// Throw: invalid number of players
        ///        invalid number of cards
        
        guard players.count == 4 else {
            print("Error: Numbers of players isn't 4 (\(players.count)).")
            throw error.invalidNumberOfPlayers
        }
        
        /// Collect cards from pool and players
        if pool != nil {
            for hand in pool!.Hands {
                Cards.append(contentsOf: hand.Cards)
                hand.Cards.removeAll()
            }
        }
        /// Calculate score change of players
        var scoreWin = 0
        for player in players {
            if player.Cards.count > 0 {
                player.changeScore = -player.Cards.count
                if -player.changeScore >= 10 {
                    if -player.changeScore == 13 {
                        player.changeScore *= 3
                    } else {
                        player.changeScore *= 2
                    }
                }
                scoreWin -= player.changeScore
            }
        }
        for player in players {
            if player.Cards.count == 0 {
                player.changeScore = scoreWin
                scoreWin = 0
            }
        }
        if scoreWin != 0 {
            for player in players {
                player.changeScore = 0
            }
        }
        for player in players {
            Cards.append(contentsOf: player.Cards)
            player.Cards.removeAll()
        }
        
        /// Reverse order of cards
        Cards = Cards.reversed()
        guard Cards.count == 52 else {
            print("Error: Numbers of cards isn't 52 (\(Cards.count)).")
            throw error.invalidNumberOfCards
        }
        
    }
    
/*  DEVELOPING PROGRAM
     
    init?(cards: [Card]) {
        Cards = cards
        super.init()
    }
     
    required convenience init?(coder aDecoder: NSCoder) {
        var cards = [Card]()
        for iterator in 0 ..< 52 {
            let card = aDecoder.decodeObject(forKey: "Deck\(iterator)") as! Card
            cards.append(card)
        }
        self.init(cards: cards)
    }
     
    func encode(with aCoder: NSCoder) {
        for iterator in 0 ..< Cards.count {
            aCoder.encode(Cards[iterator], forKey: "Deck\(iterator)")
        }
    }
*/
    
}
