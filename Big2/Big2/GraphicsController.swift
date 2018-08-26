//
//  Graphics.swift
//  Big2
//
//  Created by Tsznok Wong on 1/4/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit

let defaultFontName = "Supercell-Magic"                 /// Font name
let defaultFontSize = CGFloat(22)                       /// Font size

class GraphicsController {
    
    /// Basic sprites
    let background = SKSpriteNode(imageNamed: "Background")
    let Back = Button(imageNamed: "Back")
    let Next = Button(imageNamed: "Next")
    
    /// Menu sprites
    let StartButton = Button(imageNamed: "StartButton")
    let EasyButton = Button(imageNamed: "EasyButton")
    let NormalButton = Button(imageNamed: "NormalButton")
    let SettingButton = Button(imageNamed: "SettingButton")
    
    /// How to play sprites
    let howToPlay = Button(imageNamed: "HowToPlay")
    var instructionPage: Int = 1
    let instruction = SKSpriteNode()
    let closeButton = Button(imageNamed: "Exit")

    /// Gaming sprites
    let RedDot = SKSpriteNode(imageNamed: "RedDot")
    let DealButton = Button(imageNamed: "DealButton")
    let PassButton = Button(imageNamed: "PassButton")
    let SortButton = Button(imageNamed: "SortButton")
    let DetailButton = Button(imageNamed: "Detail")
    
    /// Pause sprite
    let PauseButton = Button(imageNamed: "Pause")
    let QuitButton = Button(imageNamed: "Quit")
    let RestartButton = Button(imageNamed: "RestartButton")
    let filter = SKSpriteNode(color: UIColor.black, size: CGSize(width: ViewWidth, height: ViewHeight))

    /// Setting Sprite
    let volumeBar = SKSpriteNode(imageNamed: "VolumeBar")
    let slider = SKSpriteNode(imageNamed: "Slider")
    let vibrateToggle = Button()
    let vibrateTrue = SKTexture(imageNamed: "Vibrate")
    let vibrateFalse = SKTexture(imageNamed: "VibrateCancel")
    
    init() {
        ///Initialize
        
        // Image Data:  Size: 1210 * 838
        //              File: Background
        background.name = "Background"
        background.size = CGSize(width: ViewWidth, height: ViewHeight)
        background.zPosition = 0
        background.position = CGPoint(x: ViewWidth / 2, y: ViewHeight / 2)
        
        // Image Data:  Size: 96 * 96
        //              File: Back
        Back.name = "BackButton"
        Back.size = CGSize(width: ViewWidth / 9, height: ViewWidth / 9)
        Back.zPosition = 303
        
        // Image Data:  Size: 96 * 96
        //              File: Next
        Next.name = "NextButton"
        Next.size = CGSize(width: ViewWidth / 9, height: ViewWidth / 9)
        Next.zPosition = 303
        
        // Image Data:  Size: 253 * 253
        //              File: StartButton
        StartButton.name = "StartButton"
        StartButton.zPosition = 300
        
        // Image Data:  Size: 320 * 110
        //              File: EasyButton
        EasyButton.name = "EasyButton"
        EasyButton.size = CGSize(width: ViewWidth / 4, height: ViewWidth / 4 / 320 * 110)
        EasyButton.position = CGPoint(x: ViewWidth / 5 , y: ViewHeight * 3 / 7)
        EasyButton.zPosition = 99
        
        // Image Data:  Size: 320 * 110
        //              File: NormalButton
        NormalButton.name = "NormalButton"
        NormalButton.size = CGSize(width: ViewWidth / 4, height: ViewWidth / 4 / 320 * 110)
        NormalButton.position = CGPoint(x: ViewWidth / 2 , y: ViewHeight * 3 / 7)
        NormalButton.zPosition = 99
        
        // Image Data:  Size: 254 * 254
        //              File: SettingButton
        SettingButton.name = "SettingButton"
        SettingButton.size = CGSize(width: ViewWidth / 8, height: ViewWidth / 8)
        SettingButton.position = CGPoint(x: ViewWidth / 8 , y: ViewHeight * 5 / 6)
        SettingButton.zPosition = 99
    
        // Image Data:  Size: 222 * 222
        //              File: HowToPlay
        howToPlay.name = "howToPlayButton"
        howToPlay.size = CGSize(width: ViewWidth / 11, height: ViewWidth / 11)
        howToPlay.position = CGPoint(x: ViewWidth * 8 / 9 , y: ViewHeight * 5 / 6)
        howToPlay.zPosition = 298
        
        // Image Data:  Size: 837 * 526
        //              File: Instruction*
        instruction.name = "instruction"
        instruction.size = CGSize(width: ViewHeight * 9 / 10 / 526 * 837, height: ViewHeight * 9 / 10)
        instruction.position = CGPoint(x: ViewWidth / 2, y: ViewHeight / 2)
        instruction.zPosition = 301
        
        // Image Data:  Size: 232 * 232
        //              File: Exit
        closeButton.name = "closeButton"
        closeButton.size = CGSize(width: ViewWidth / 11, height: ViewWidth / 11)
        closeButton.zPosition = 302
        
        // Image Data:  Size: 247 * 247
        //              File: RedDot
        RedDot.size = CGSize(width: ViewWidth / 30, height: ViewWidth / 30)
        RedDot.isHidden = true
        RedDot.zPosition = 1
        
        // Image Data:  Size: 160 * 160
        //              File: DealButton
        DealButton.name = "DealButton"
        DealButton.size = CGSize(width: ViewWidth / 10, height: ViewWidth / 10)
        DealButton.position = CGPoint(x: ViewWidth * 0.75 , y: ViewHeight * 6 / 15)
        DealButton.zPosition = 298

        // Image Data:  Size: 160 * 160
        //              File: PassButton
        PassButton.name = "PassButton"
        PassButton.size = CGSize(width: ViewWidth / 10, height: ViewWidth / 10)
        PassButton.position = CGPoint(x: ViewWidth * 0.25 , y: ViewHeight * 6 / 15)
        PassButton.zPosition = 298
        
        // Image Data:  Size: 160 * 160
        //              File: SortButton
        SortButton.name = "SortButton"
        SortButton.size = CGSize(width: ViewWidth / 10, height: ViewWidth / 10)
        SortButton.position = CGPoint(x: ViewWidth / 2 , y: ViewHeight * 6 / 15)
        SortButton.zPosition = 298
        
        // Image Data:  Size: 214 * 214
        //              File: Detail
        DetailButton.name = "DetailButton"
        DetailButton.size = CGSize(width: ViewWidth / 13, height: ViewWidth / 13)
        DetailButton.position = CGPoint(x: ViewWidth * 19 / 20 , y: ViewHeight / 11)
        DetailButton.zPosition = 298
        
        // Image Data:  Size: 209 * 209
        //              File: Pause
        PauseButton.name = "PauseButton"
        PauseButton.size = CGSize(width: ViewWidth / 12, height: ViewWidth / 12)
        PauseButton.position = CGPoint(x: ViewWidth / 9 , y: ViewHeight * 5 / 6)
        PauseButton.zPosition = 299
        
        // Image Data:  Size: 234 * 234
        //              File: Pause
        QuitButton.name = "QuitButton"
        QuitButton.size = CGSize(width: ViewWidth / 9, height: ViewWidth / 9)
        QuitButton.position = CGPoint(x: ViewWidth / 4, y: ViewHeight / 2)
        QuitButton.zPosition = 300
        
        // Image Data:  Size: 139 * 139
        //              File: RestartButton
        RestartButton.name = "RestartButton"
        RestartButton.size = CGSize(width: ViewWidth / 9, height: ViewWidth / 9)
        RestartButton.position = CGPoint(x: ViewWidth * 3 / 4 , y: ViewHeight / 2)
        RestartButton.zPosition = 300
        
        filter.name = "filter"
        filter.position = CGPoint(x: ViewWidth / 2, y: ViewHeight / 2)
        filter.alpha = 0.6
        filter.zPosition = 299
        
        // Image Data:  Size: 449 * 51
        //              File: VolumeBar
        volumeBar.name = "volumeBar"
        volumeBar.size = CGSize(width: ViewWidth / 3, height: ViewWidth / 3 / 449 * 51)
        volumeBar.position = CGPoint(x: ViewWidth / 2 , y: ViewHeight / 2)
        volumeBar.zPosition = 99

        // Image Data:  Size: 105 * 186
        //              File: Slider
        slider.name = "slider"
        slider.size = CGSize(width: ViewWidth / 14, height: ViewWidth / 14 / 105 * 186)
        slider.zPosition = 100
        
        // Image Data:  Size: 74 * 76
        //              File: Vibrate, VibrateCancel
        vibrateToggle.name = "vibrateToggle"
        vibrateToggle.size = CGSize(width: ViewWidth / 9, height: ViewWidth / 9 / 74 * 76)
        vibrateToggle.position = CGPoint(x: ViewWidth * 8 / 9 , y: ViewHeight * 5 / 6)
        vibrateToggle.zPosition = 99
    }
    
    internal func initGameView(_ scene: SKScene) {
        /// Initialize game view
        print("Initialize GameView")
        func setHiddenAndAddChild(_ node: SKSpriteNode) {
            node.isHidden = true
            scene.addChild(node)
        }
        let Nodes = [DealButton, PassButton, SortButton, DetailButton, RedDot]
        for node in Nodes {
            setHiddenAndAddChild(node)
        }
        
        scene.addChild(PauseButton)
        scene.addChild(howToPlay)
    }
    
    internal func gameStart() {
        /// Show hidden sprite
        RedDot.isHidden = false
        SortButton.isHidden = false
        DetailButton.isHidden = false
    }
    
    internal func updateRedDot() {
        /// Update red dot pointer position
        RedDot.position = CGPoint(x: (game.players[game.currentPlayer!].position.x + ViewWidth / 2) / 2, y: (game.players[game.currentPlayer!].position.y + ViewHeight / 2 + 20) / 2)
    }
    
    internal func hidePlayerButtons(state: Bool) {
        /// Set player's buttons hidden state
        DealButton.isHidden = state
        PassButton.isHidden = state
    }
    
    internal func showDetails(_ scene: SKScene) {
        /// Show label of buttons
        DetailButton.isHidden = true
        func setDetailLabelAndAddChild(_ node: SKOutlinedLabelNode) {
            node.alpha = 0
            node.borderWidth = 5
            node.zPosition = 99
            node.run(SKAction.fadeIn(withDuration: 0.5))
            scene.addChild(node)
        }
        
        let passLabel = SKOutlinedLabelNode(fontSize: defaultFontSize - 5)
        passLabel.outlinedText = "Pass"
        passLabel.name = "passLabel"
        passLabel.position = CGPoint(x: PassButton.position.x, y: PassButton.position.y + PassButton.frame.height * 2 / 3)
        setDetailLabelAndAddChild(passLabel)
        
        let sortLabel = SKOutlinedLabelNode(fontSize: defaultFontSize - 5)
        sortLabel.outlinedText = "Sort"
        sortLabel.name = "sortLabel"
        sortLabel.position = CGPoint(x: SortButton.position.x, y: SortButton.position.y + SortButton.frame.height * 2 / 3)
        setDetailLabelAndAddChild(sortLabel)
        
        let dealLabel = SKOutlinedLabelNode(fontSize: defaultFontSize - 5)
        dealLabel.outlinedText = "Deal"
        dealLabel.name = "dealLabel"
        dealLabel.position = CGPoint(x: DealButton.position.x, y: DealButton.position.y + DealButton.frame.height * 2 / 3)
        setDetailLabelAndAddChild(dealLabel)
    }
    
    internal func removeDetails(_ scene: SKScene) {
        /// Remove label of buttons
        DetailButton.isHidden = false
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.removeFromParent()
        let Labels = ["passLabel", "sortLabel", "dealLabel"]
        for label in Labels {
            scene.enumerateChildNodes(withName: label, using: {
                (node, error) in node.run(SKAction.sequence([fadeOut, remove]))
            })
        }
    }
    
    internal func showInstructions(_ scene: SKScene) {
        /// Show instruction interface
        howToPlay.isHidden = true
        PauseButton.isHidden = true
        
        if instruction.frame.width > ViewWidth {
            instruction.size = CGSize(width: ViewWidth * 9 / 10, height: ViewWidth * 9 / 10 / 837 * 526)
        }
        closeButton.position = CGPoint(x: ViewWidth / 2 + instruction.frame.width / 2 - 15,
                                       y: ViewHeight / 2 + instruction.frame.height / 2 - 15)
        Back.position = CGPoint(x: ViewWidth / 2 - instruction.frame.width * 2 / 5, y: ViewHeight / 2 - instruction.frame.height * 2 / 5)
        Next.position = CGPoint(x: ViewWidth / 2 + instruction.frame.width * 2 / 5, y: ViewHeight / 2 - instruction.frame.height * 2 / 5)
        
        let Nodes = [filter, instruction, closeButton, Back, Next]
        scene.addChildren(Nodes)
 
        updateInstructions(scene)
    }
    
    internal func updateInstructions(_ scene: SKScene) {
        /// Update instruction page
        Back.isHidden = false
        Next.isHidden = false
        
        let texture = SKTexture(imageNamed: "Instruction\(instructionPage)")
        instruction.texture = texture
        if instructionPage == 1 {
            Back.isHidden = true
        } else if instructionPage == totalInstructionPage {
            Next.isHidden = true
        }
    }
    
    internal func removeInstructions(_ scene: SKScene) {
        /// Remove instruction page
        howToPlay.isHidden = false
        PauseButton.isHidden = false

        let Nodes = [filter, instruction, closeButton, Next, Back]
        for node in Nodes {
            node.removeFromParent()
        }
        resume()
    }
    
    internal func pause() {
        /// Pause game
        guard isGameScene else {
            return
        }
        PauseButton.isHidden = true
        
        StartButton.size = CGSize(width: ViewWidth / 8, height: ViewWidth / 8)
        StartButton.position = CGPoint(x: ViewWidth / 2 , y: ViewHeight / 2)
        StartButton.isHidden = false

        var Nodes = [filter, QuitButton, StartButton]
        if game.move < 4 {
            Nodes.append(RestartButton)
        }
        for node in Nodes {
            node.removeFromParent()
        }
        gameScene.addChildren(Nodes)
    }
    
    internal func resume() {
        /// Resume game
        guard isGameScene else {
            return
        }
        PauseButton.isHidden = false
        
        let Nodes = [filter, QuitButton, StartButton, RestartButton]
        for node in Nodes {
            node.removeFromParent()
        }
    }
    
    internal func initMenuView(_ scene: SKScene) {
        /// Initialize menu view
        StartButton.removeFromParent()
        StartButton.size = CGSize(width: ViewWidth / 6, height: ViewWidth / 6)
        StartButton.position = CGPoint(x: ViewWidth / 2 , y: ViewHeight * 3 / 7)
        showGameModes(state: false)

        // Image Data:  Size: 625 * 366
        //              File: Logo
        let Logo = SKSpriteNode(imageNamed: "Logo")
        Logo.name = "Logo"
        Logo.size = CGSize(width: ViewWidth / 3, height: ViewWidth / 3 / 625 * 366)
        Logo.position = CGPoint(x: ViewWidth / 2, y: ViewHeight * 0.77)
        Logo.zPosition = 99

        let scoreLabel = SKOutlinedLabelNode(fontSize: defaultFontSize)
        scoreLabel.outlinedText = "Score: \(game.players[0].score)"
        scoreLabel.name = "ScoreLabel"
        scoreLabel.position = CGPoint(x: ViewWidth / 2, y: ViewHeight / 6)
        scoreLabel.zPosition = 99
        
        let Nodes = [Logo, StartButton, EasyButton, NormalButton, SettingButton, scoreLabel, howToPlay]
        scene.addChildren(Nodes)
    }
    
    internal func showGameModes(state: Bool) {
        /// Set game modes hidden state
        StartButton.isHidden = state
        EasyButton.isHidden = !state
        NormalButton.isHidden = !state
    }
    
    internal func initGameoverView(_ scene: SKScene) {
        /// Initialize gameover view
        Back.removeFromParent()
        Next.removeFromParent()
        Back.isHidden = false
        Next.isHidden = false
        Back.position = CGPoint(x: ViewWidth / 9, y: ViewHeight * 5 / 6)
        Next.position = CGPoint(x: ViewWidth * 8 / 9 , y: ViewHeight / 6)
        
        // Image Data:  Size: 1420 * 857
        //              File: Win, Lose
        let lastHand = game.lastHand
        let resultLabel = SKSpriteNode(imageNamed: lastHand?.playedBy == "Player" ? "Win" : "Lose")
        resultLabel.name = "resultLabel"
        resultLabel.size = CGSize(width: 0, height: 0)
        resultLabel.position = CGPoint(x: ViewWidth / 2 , y: ViewHeight * 2 / 3)
        resultLabel.zPosition = 10
        resultLabel.isHidden = false
        resultLabel.alpha = 0
        
        /// Animate gameover scene
        let timeToEnlarge = 0.5
        let timeToWait = 0.5
        let timeToShrink = 0.5
        let enlarge = SKAction.resize(toWidth: ViewWidth / 2, height: ViewWidth / 2 / 1420 * 857, duration: timeToEnlarge)
        let fadeIn = SKAction.fadeIn(withDuration: timeToEnlarge)
        let move = SKAction.move(to: CGPoint(x: ViewWidth / 3, y: ViewHeight * 3 / 4), duration: timeToShrink)
        let resize = SKAction.resize(toWidth: ViewWidth / 4, height: ViewWidth / 4 / 1420 * 857, duration: timeToShrink)
        let moveUpAndResize = SKAction.group([move, resize])
        let waitToShowBoard = SKAction.wait(forDuration: timeToEnlarge + timeToWait)
        let waitAndMove = SKAction.sequence([waitToShowBoard, moveUpAndResize])
        resultLabel.run(SKAction.group([enlarge, fadeIn, waitAndMove]))
        
        for card in (lastHand?.Cards)! {
            card.removeFromParent()
            scene.addChild(card)
        }
        lastHand?.handVisualize(CGPoint(x: ViewWidth / 2, y: ViewHeight / 3), zPosition: 12, duration: timeToEnlarge)
        delay(delay: timeToEnlarge + timeToWait, closure: {
            lastHand?.handVisualize(CGPoint(x: ViewWidth * 2 / 3, y: ViewHeight * 3 / 4), zPosition: 12, duration: timeToShrink)
        })

        /// Set score result table
        var Nodes: [SKNode] = [resultLabel, Next, Back]
        var iterator: Int = 0
        var players = [Computer]()
        var winnerIndex: Int = 0
        players.reserveCapacity(4)
        players = game.players
        for player in players {
            let playerNameLabel = SKOutlinedLabelNode(fontSize: defaultFontSize - 5)
            playerNameLabel.outlinedText = player.playerName
            playerNameLabel.name = "playerNameLabel"
            playerNameLabel.position = CGPoint(x: ViewWidth * CGFloat(iterator * 2 + 1) / 8, y: ViewHeight / 2)
            playerNameLabel.fontColor = UIColor.yellow
            playerNameLabel.zPosition = 99
            playerNameLabel.alpha = 0
            playerNameLabel.borderWidth = 5
            playerNameLabel.run(SKAction.sequence([waitToShowBoard, SKAction.fadeIn(withDuration: 0.1)]))
            
            let scoreLabel = player.scoreLabel
            scoreLabel.outlinedText = "\(player.score)"
            scoreLabel.position = CGPoint(x: ViewWidth * CGFloat(iterator * 2 + 1) / 8, y: ViewHeight * 0.325)
            scoreLabel.alpha = 0
            scoreLabel.run(SKAction.sequence([waitToShowBoard, SKAction.fadeIn(withDuration: 0.1)]))
            
            Nodes.append(playerNameLabel)
            Nodes.append(scoreLabel)
            
            if player.changeScore > 0 {
                winnerIndex = iterator
            }
            iterator += 1
        }

        func addValue() {
            /// Animate and update score results
            if players[winnerIndex].changeScore > 0 {
                var add = 0
                for player in players {
                    if player.changeScore < 0 {
                        add += 1
                        player.changeScore += 1
                        player.score -= 1
                        player.scoreLabel.outlinedText = "\(player.score)"
                    }
                }
                players[winnerIndex].changeScore -= add
                players[winnerIndex].score += add
                players[winnerIndex].scoreLabel.outlinedText = "\(players[winnerIndex].score)"
                
                /// Initiate adding next value
                delay(delay: 0.25, closure: {
                    addValue()
                })
            }
            
        }
        
        /// Add value
        delay(delay: timeToEnlarge + timeToWait + 0.1, closure: {
            addValue()
        })
        
        scene.addChildren(Nodes)
    }
    
    internal func reshuffling() {
        /// Add reshuffling message
        print("Reshuffling Message")
        let reshufflingMessage = Message(fontSize: defaultFontSize)
        reshufflingMessage.outlinedText = "Reshuffling"
        reshufflingMessage.name = "Reshuffling"
        reshufflingMessage.setDefaultLabel()
        reshufflingMessage.fadeInFadeOut(gameScene)
    }
    
    internal func randomTips() {
        /// Add random tip message
        print("Tips Message")
        let tipsMessage = Message(fontSize: defaultFontSize)
        tipsMessage.outlinedText = Tips[randomInt(min: 0, max: Tips.count - 1)]
        tipsMessage.name = "Tips"
        tipsMessage.setDefaultLabel()
        tipsMessage.fadeInFadeOut(gameScene)
    }
    
    internal func alertPlayCardCorrectly() {
        /// Add alert to player (play card correctly)
        print("Play A Hand Correctly Message")
        let alert = Message(fontSize: defaultFontSize)
        alert.outlinedText = "Play A Hand Correctly"
        alert.name = "Play A Hand Correctly"
        alert.setDefaultLabel()
        alert.fadeInFadeOut(gameScene)
    }
    
    internal func initSettingView(_ scene: SKScene) {
        /// Initialize setting view
        Back.removeFromParent()
        Back.isHidden = false
        Back.position = CGPoint(x: ViewWidth / 9, y: ViewHeight * 5 / 6)

        let volumeLabel = SKOutlinedLabelNode(fontSize: defaultFontSize + 24)
        volumeLabel.outlinedText = "Volume"
        volumeLabel.name = "VolumeLabel"
        volumeLabel.position = CGPoint(x: ViewWidth / 2, y: ViewHeight * 3 / 4)
        volumeLabel.fontColor = UIColor.yellow
        volumeLabel.zPosition = 99

        let ratioLength = volumeBar.frame.width * CGFloat(audioController.volume)
        slider.position = CGPoint(x: ViewWidth / 2 - volumeBar.frame.width / 2 + ratioLength, y: ViewHeight / 2)
        vibrateToggle.texture = vibrate ? vibrateTrue : vibrateFalse
        
        print("Slide to Change Volume")
        let volumeRemind = Message(fontSize: defaultFontSize)
        volumeRemind.outlinedText = "Slide to Change Volume"
        volumeRemind.name = "Slide to Change Volume"
        volumeRemind.setDefaultLabel()
        volumeRemind.fadeInFadeOut(scene)
        
        let Nodes = [Back, volumeLabel, volumeBar, slider, vibrateToggle]
        scene.addChildren(Nodes)
    }
}

class Button: SKSpriteNode {
    
    internal func tap() {
        /// Perform tap animation
        let liftUp = SKAction.scale(to: 1.1, duration: 0.3)
        let dropDown = SKAction.scale(to: 1.0, duration: 0.3)
        run(SKAction.sequence([liftUp, dropDown]), withKey: "tap")
    }
    
}


class SKOutlinedLabelNode: SKLabelNode {
    
    /// Modified from MKOutlinedLabelNode by Mario Klavar
    /// More details in disclaimer
    
    var borderColor: UIColor = UIColor.black
    var borderWidth: CGFloat = 7.0
    var borderOffset : CGPoint = CGPoint(x: 0, y: 0)
    enum borderStyleType {
        case over
        case under
    }
    var borderStyle = borderStyleType.under
    var outlinedText: String! {
        didSet { drawText() }
    }
    private var border: SKShapeNode?
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override init() { super.init() }
    
    init(fontNamed fontName: String! = defaultFontName, fontSize: CGFloat) {
        super.init(fontNamed: fontName)
        self.fontSize = fontSize
        fontColor = UIColor.white
    }
    
    func drawText() {
        if let borderNode = border {
            borderNode.removeFromParent()
            border = nil
        }
        
        if let text = outlinedText {
            self.text = text
            if let path = createBorderPathForText() {
                let border = SKShapeNode()
                
                border.strokeColor = borderColor
                border.lineWidth = borderWidth;
                border.path = path
                border.position = positionBorder(border: border)
                switch self.borderStyle {
                case borderStyleType.over:
                    border.zPosition = self.zPosition + 1
                    break
                default:
                    border.zPosition = self.zPosition - 1
                }
                
                addChild(border)
                
                self.border = border
            }
        }
    }
    
    private func getTextAsCharArray() -> [UniChar] {
        var chars = [UniChar]()
        
        for codeUnit in (text?.utf16)! {
            chars.append(codeUnit)
        }
        return chars
    }
    
    private func createBorderPathForText() -> CGPath? {
        let chars = getTextAsCharArray()
        guard let fontName = self.fontName else { return nil }
        let borderFont = CTFontCreateWithName(fontName as CFString, self.fontSize, nil)
        
        var glyphs = Array<CGGlyph>(repeating: 0, count: chars.count)
        let gotGlyphs = CTFontGetGlyphsForCharacters(borderFont, chars, &glyphs, chars.count)
        
        if gotGlyphs {
            var advances = Array<CGSize>(repeating: CGSize(), count: chars.count)
            CTFontGetAdvancesForGlyphs(borderFont, CTFontOrientation.horizontal, glyphs, &advances, chars.count);
            
            let letters = CGMutablePath()
            var xPosition = 0 as CGFloat
            for index in 0...(chars.count - 1) {
                let letter = CTFontCreatePathForGlyph(borderFont, glyphs[index], nil)
                let t = CGAffineTransform(translationX: xPosition , y: 0)
                if letter != nil {
                    letters.addPath(letter!, transform: t)
                }
                xPosition += advances[index].width
            }
            
            return letters
        } else {
            return nil
        }
    }
    
    private func positionBorder(border: SKShapeNode) -> CGPoint {
        let sizeText = self.calculateAccumulatedFrame()
        let sizeBorder = border.calculateAccumulatedFrame()
        let offsetX = sizeBorder.width - sizeText.width
        
        switch self.horizontalAlignmentMode {
        case SKLabelHorizontalAlignmentMode.center:
            return CGPoint(x: -(sizeBorder.width / 2) + offsetX/2.0 + self.borderOffset.x, y: 1 + self.borderOffset.y)
        case SKLabelHorizontalAlignmentMode.left:
            return CGPoint(x: sizeBorder.origin.x - self.borderWidth*2 + offsetX + self.borderOffset.x, y: 1 + self.borderOffset.y)
        default:
            return CGPoint(x: sizeBorder.origin.x - sizeText.width - self.borderWidth*2 + offsetX + self.borderOffset.x, y: 1 + self.borderOffset.y)
        }
    }

}

class Message: SKOutlinedLabelNode {
    
    internal func setDefaultLabel() {
        /// Set property of alert message
        self.position = CGPoint(x: ViewWidth / 2, y: ViewHeight / 2)
        self.fontColor = UIColor.white
        self.zPosition = 298
    }
    
    internal func fadeInFadeOut(_ scene: SKScene) {
        /// Set animation of alert message
        self.alpha = 0
        scene.addChild(self)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.8)
        let moveUp = SKAction.moveBy(x: 0, y: 20, duration: 0.8)
        let fadeOutAndMoveUp = SKAction.group([fadeOut, moveUp])
        run(SKAction.sequence([fadeIn, wait, fadeOutAndMoveUp, SKAction.removeFromParent()]))
    }
}

