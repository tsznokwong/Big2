//
//  card.swift
//  Big2
//
//  Created by Tsznok Wong on 2/3/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit


class Card : SKSpriteNode {
    
    var rank = String()                     /// Rank of card
    var suit = String()                     /// Suit of card
    var deal = Bool()                       /// Is card deal
    var faceup = Bool()                     /// Is card face up
    var cardFace = SKTexture()              /// Texture of card face
    var cardBack = SKTexture()              /// Texture of card back

    convenience init (rank: String, suit: String) {
        /// Initialize card
        
        // Image Data:  Size: 2340 * 1008
        //              File: pokerCards
        let tmpTexture = SKTexture(rect:
                        CGRect(x: CGFloat((Rank.index(of: rank)! + 2) % 13) / 13.0,
                               y: CGFloat(3 - (Suit.index(of: suit)! + 2) % 4) / 4.0,
                               width: 1 / 13.0,
                               height: 0.25),
                               in: SKTexture(imageNamed: "pokerCards"))
        self.init(texture: tmpTexture, color: UIColor.black, size: CGSize(width: 0, height: 0))
        self.rank = rank
        self.suit = suit
        name = "\(rank) \(suit)"
        deal = false
        faceup = false
        // Image Data:  Size: 272 * 381
        //              File: cardBack
        cardBack = SKTexture(imageNamed: "cardBack")
        cardFace = tmpTexture
    }

    
    internal func initCardSprite() {
        /// Initialize card for start of game
        deal = false
        faceup = false
        texture = cardBack
        run(SKAction.move(to: CGPoint(x: ViewWidth / 2, y: ViewHeight / 2),
                          duration: 0.3))
        run(SKAction.resize(toWidth: ViewWidth / 6,
                            height: ViewWidth / 6 / 272 * 381,
                            duration: 0.3))
        run(SKAction.rotate(toAngle: 0, duration: 0.3))
        zPosition = 0
    }
    
    internal func printCard() {
        /// Print card
        print(name!)
    }
    
    internal func flip() {
        /// Flip face of card
        faceup.toggle()
        texture = faceup ? cardFace : cardBack
    }
    
    internal func toggle() {
        /// Toggle placement of card
        deal.toggle()
        run(SKAction.moveTo(y: deal ? 30 : 0, duration: 0.1))
    }
    
/*  DEVELOPING PROGRAM
     
    struct PropertyKey {
        static let rankKey = "Rank"
        static let suitKey = "Suit"
    }
     
    required convenience init? (coder aDecoder: NSCoder) {
        let rank = aDecoder.decodeObject(forKey: PropertyKey.rankKey) as! String
        let suit = aDecoder.decodeObject(forKey: PropertyKey.suitKey) as! String
        self.init(rank: rank, suit: suit)
    }
     
    override func encode (with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(rank, forKey: PropertyKey.rankKey)
        aCoder.encode(suit, forKey: PropertyKey.suitKey)
    }
*/
}






