//
//  AudioController.swift
//  Big2
//
//  Created by Tsznok Wong on 16/10/2016.
//  Copyright © 2016 Tsznok Wong. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import AudioToolbox

class AudioController {
    
    var volume: Float = 0.5                                /// Volume of audio
    var BGMPlayer = AVAudioPlayer()                        /// Player of background music
    var Player = SKNode()                                  /// Player node
    
    init() {
        /// Get data from internal storage
        let volumeValue = UserDefaults.standard
        if volumeValue.value(forKey: "volume") != nil {
            volume = volumeValue.value(forKey: "volume") as! Float
        }
        let vibrateValue = UserDefaults.standard
        if vibrateValue.value(forKey: "vibrate") != nil {
            vibrate = vibrateValue.value(forKey: "vibrate") as! Bool
        } else {
            vibrate = true
        }
        
        /// Set background music
        let BGMURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Audio Resources/Lights", ofType: "mp3")!)
        do{
            try BGMPlayer = AVAudioPlayer(contentsOf: BGMURL)
        } catch{
            print("Audio Error")
        }
        BGMPlayer.numberOfLoops = -1
        BGMPlayer.play()
        changeVolume(to: volume)
        
    }
    
    internal func changeVolume(to: Float) {
        /// Change volume
        volume = to
        BGMPlayer.volume = to
    }
    
    internal func intro() {
        /// Add introduction sound effect
        addSoundEffect(fileNamed: "Audio Resources/IntroEffect.wav", duration: 2.0)
    }
    internal func dealCard() {
        /// Add deal card sound effect
        let rand = randomInt(min: 1, max: 12)
        addSoundEffect(fileNamed: "Audio Resources/DealCard\(rand).caf", duration: 1.5)
    }
    private func addSoundEffect(fileNamed: String, duration: TimeInterval) {
        /// Change add sound effect
        let soundEffect = SKAudioNode(fileNamed: fileNamed)
        Player.addChild(soundEffect)
        soundEffect.autoplayLooped = false
        soundEffect.run(SKAction.changeVolume(to: volume, duration: 0))
        let playRemove = SKAction.sequence([SKAction.play(), SKAction.wait(forDuration: duration), SKAction.removeFromParent()])
        soundEffect.run(playRemove, withKey: "playRemove")
    }
    
    internal func vibrator() {
        /// Add vibration
        if vibrate {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    internal func saveSetting() {
        let volumeValue = UserDefaults.standard
        volumeValue.set(audioController.volume, forKey: "volume")
        volumeValue.synchronize()
        let vibrateValue = UserDefaults.standard
        vibrateValue.set(vibrate, forKey: "vibrate")
        vibrateValue.synchronize()
    }
}
