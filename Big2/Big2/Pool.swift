//
//  Pool.swift
//  Big2
//
//  Created by Tsznok Wong on 14/5/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation


class Pool {
    
    var Hands = [Hand]()                    /// Hands of pool
    
    internal func checkHand(_ hand: inout Hand, leading: Bool) throws {
        /// Throw: number of cards not equal to pool
        ///        invalid card
        ///        invalid hand card combination
        ///        hand value smaller than in pool
        
        func handValueSmallerThanInPool() -> Error {
            /// Return: hand value smaller than in pool
            
            /// Print hand and hand in top of pool
            print("Error: Hand value is smaller than the pool.")
            print("Your Hand")
            hand.printHand()
            print("Pool")
            Hands.last?.printHand()
            return error.handValueSmallerThanInPool
        }
        
        func checkSame(_ cards: [Card], value: Value) throws -> Bool {
            /// Throw: invalid number of cards
            ///        invalid value
            /// Return: is all cards in same value
            
            guard cards.count >= 1 else {
                print("Error: Invalid number of cards (\(cards.count)).")
                throw error.invalidNumberOfCards
            }
            guard value == Value.rank || value == Value.suit else {
                print("Error: Unable to sort by unknown value (\(value))")
                throw error.invalidValue
            }
            
            var sample = String()
            if value == Value.rank {
                sample = cards.first!.rank
            } else if value == Value.suit {
                sample = cards.first!.suit
            }
            for card in cards {
                if value == Value.rank && sample != card.rank {
                    return false
                } else if value == Value.suit && sample != card.suit {
                    return false
                }
            }
            return true
        }
        
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
        
        func checkStraight() throws -> Bool {
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
        
        func checkFullHouse() throws -> Bool {
            /// Throw: invalid number of cards
            /// Return: is the hand a full house
            
            let cards = hand.Cards
            guard cards.count == 5 else {
                print("Error: Number of cards not equal to 5 (\(cards.count)).")
                throw error.invalidNumberOfCards
            }
            var leftCards = [Card]()
            var rightCards = [Card]()
            leftCards.append(contentsOf: cards.dropLast(2))
            rightCards.append(contentsOf: cards.dropFirst(3))
            if try checkSame(leftCards, value: Value.rank) && checkSame(rightCards, value: Value.rank) {
                hand.comparingCard = cards[2]
                return true
            }
            leftCards.removeAll()
            rightCards.removeAll()
            leftCards.append(contentsOf: cards.dropLast(3))
            rightCards.append(contentsOf: cards.dropFirst(2))
            if try checkSame(leftCards, value: Value.rank) && checkSame(rightCards, value: Value.rank) {
                hand.comparingCard = cards[4]
                return true
            }
            return false
        }
        
        func checkFourOfAKind() throws -> Bool {
            /// Throw: invalid number of cards
            /// Return: is the hand a four of a kind

            let cards = hand.Cards
            guard cards.count == 5 else {
                print("Error: Number of cards not equal to 5 (\(cards.count)).")
                throw error.invalidNumberOfCards
            }
            var leftCards = [Card]()
            leftCards.append(contentsOf: cards.dropLast())
            if try checkSame(leftCards, value: Value.rank) {
                hand.comparingCard = cards[3]
                return true
            }
            leftCards.removeAll()
            leftCards.append(contentsOf: cards.dropFirst())
            if try checkSame(leftCards, value: Value.rank) {
                hand.comparingCard = cards[4]
                return true
            }
            return false
        }
        
        func checkDuplicate() -> Bool {
            /// Return: is card duplicated
            
            var codeForCards = [Bool]()
            for _ in 0 ..< 52 {
                codeForCards.append(false)
            }
            for card in hand.Cards {
                let index = Suit.index(of: card.suit)! + Rank.index(of: card.rank)! * 4
                if codeForCards[index] {
                    return true
                } else {
                    codeForCards[index] = true
                }
            }
            return false
        }
        
        guard leading || hand.Cards.count == Hands.last?.Cards.count else {
            print("Error: Number of cards not equal to pool (hand: \(hand.Cards.count), pool: \(Hands.last!.Cards.count)).")
            throw error.numberOfCardsNotEqualToPool
        }
        
        if checkDuplicate() {
            print("Error: Card duplicated")
            throw error.invalidCard
        }
        hand.comparingCard = nil
        hand.powerValue = nil
        
        /// Check validity of the hand corresponding to number of cards
        switch hand.Cards.count {
        case 1 ... 3:
            var valid = Bool()
            do {
                try valid = checkSame(hand.Cards, value: Value.rank)
            } catch {}
            guard valid else {
                print("Error: Invalid hand combination (not same rank).")
                throw error.invalidHandCardCombination
            }
            if !leading && (Hands.last?.Cards.last)! > (hand.Cards.last)!{
                throw handValueSmallerThanInPool()
            }
        case 5:
            if try checkSame(hand.Cards, value: Value.suit) {
                if try checkStraight() {
                    hand.powerValue = "StraightFlush"
                } else {
                    hand.powerValue = "Flush"
                    hand.comparingCard = hand.Cards.last!
                }
            } else {
                if try checkStraight() {
                    hand.powerValue = "Straight"
                } else if try checkFullHouse() {
                    hand.powerValue = "FullHouse"
                } else if try checkFourOfAKind() {
                    hand.powerValue = "FourOfAKind"
                }
            }
            if hand.powerValue == nil || hand.comparingCard == nil {
                print("Error: Invalid hand combination (not any five hand card).")
                throw error.invalidHandCardCombination
            }
            let previousValue = Hands.last?.powerValue != nil ? fiveCardHand.index(of: (Hands.last?.powerValue)!)! : 0
            let handValue = fiveCardHand.index(of: hand.powerValue!)!
            if !leading && (previousValue > handValue || (previousValue == handValue && Hands.last?.comparingCard != nil && (Hands.last?.comparingCard)! > hand.comparingCard!) ) {
                print("\(hand.powerValue!)")
                hand.comparingCard?.printCard()
                throw handValueSmallerThanInPool()
            }
        default:
            print("Error: Invalid hand combination (\(hand.Cards.count)).")
            throw error.invalidHandCardCombination
        }
    }
}
