//
//  Function.swift
//  Big2
//
//  Created by Tsznok Wong on 3/3/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation

func randomInt(min: Int, max: Int) -> Int {
    /// Return: random Integer within a range
    return Int(arc4random() % 2147483647) % (max - min + 1) + min
}


func degreeToRadian(degree: Double) -> Double {
    /// Return: radian from degree
    return degree / 180 * .pi
}

func == (lhs: Computer, rhs: Computer) -> Bool {
    /// Return: computer equality
    return lhs.playerName == rhs.playerName
}

func == (lhs: Card, rhs: Card) -> Bool {
    /// Return: card equality
    return lhs.rank == rhs.rank && lhs.suit == rhs.suit
}

func < (lhs: Card, rhs: Card) -> Bool {
    /// Return: comparing of card (less than)
    return Rank.index(of: lhs.rank)! < Rank.index(of: rhs.rank)! || (Suit.index(of: lhs.suit)! < Suit.index(of: rhs.suit)! && Rank.index(of: lhs.rank)! == Rank.index(of: rhs.rank)!)
}

func > (lhs: Card, rhs: Card) -> Bool {
    /// Return: comparing of card (greater than)
    return rhs < lhs
}

func >= (lhs: Card, rhs: Card) -> Bool {
    /// Return: comparing of card (greater than or equal to)
    return !(lhs < rhs)
}
func <= (lhs: Card, rhs: Card) -> Bool {
    /// Return: comparing of card (less than or equal to)
    return !(lhs > rhs)
}

func delay (delay:Double, closure:@escaping ()->()) {
    /// Delay closure
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

