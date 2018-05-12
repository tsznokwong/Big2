//
//  Hand.swift
//  Big2
//
//  Created by Tsznok Wong on 14/5/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

class Hand {
    
    var Cards = [Card]()                    /// Cards of a hand
    var powerValue: String?                 /// 5-cards power value
    var comparingCard: Card?                /// Card of comparison
    var playedBy: String = ""               /// Name of player dealt the hand
    
    internal func printHand() {
        /// Print hand
        print("Hand of \(Cards.count)")
        Cards.printCards()
        if Cards.count == 5 && powerValue != nil {
            print("Power Value: \(powerValue!)")
        }
    }
    
    internal func handVisualize(_ pos: CGPoint, zPosition: CGFloat, duration: TimeInterval) {
        /// Visualize hand at a position
        var position = pos
        let deltaRotation = CGFloat(degreeToRadian(degree: 20))
        var rotation = CGFloat(Cards.count - 1) / 2 * deltaRotation
        let deltaX: CGFloat = 5
        var x = -CGFloat(Cards.count - 1) / 2 * deltaX + position.x
        var iterator = zPosition
        for card in Cards {
            if !card.faceup {
                card.flip()
            }
            position.x = x
            card.run(SKAction.move(to: position, duration: duration))
            card.run(SKAction.rotate(toAngle: rotation, duration: duration))
            card.run(SKAction.resize(toWidth: ViewWidth / 8,
                                     height: ViewWidth / 8 / 272 * 381,
                                     duration: duration))
            card.zPosition = iterator
            rotation -= deltaRotation
            x += deltaX
            iterator += 1
        }
    }
}
