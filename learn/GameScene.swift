//
//  GameScene.swift
//  learn
//
//  Created by Devon Law on 2019-07-23.
//  Copyright © 2019 Slacker. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var block1 = SKSpriteNode()
    var block2 = SKSpriteNode()
    var block3 = SKSpriteNode()
    var block4 = SKSpriteNode()
    var long1 = SKSpriteNode()
    var long2 = SKSpriteNode()
    var longest1 = SKSpriteNode()
    var height = CGFloat(0.0)
    var ball = SKSpriteNode()
    var ballHeight = SKLabelNode()
    var timeLabel = SKLabelNode()
    var endScore = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var timer:Timer?
    var timeLeft = 30
    
    override func didMove(to view: SKView) {
        endScore = self.childNode(withName: "endScore") as! SKLabelNode
        block1 = self.childNode(withName: "block1") as! SKSpriteNode
        block2 = self.childNode(withName: "block2") as! SKSpriteNode
        block3 = self.childNode(withName: "block3") as! SKSpriteNode
        block4 = self.childNode(withName: "block4") as! SKSpriteNode
        long1 = self.childNode(withName: "long1") as! SKSpriteNode
        long2 = self.childNode(withName: "long2") as! SKSpriteNode
        longest1 = self.childNode(withName: "longest1") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ballHeight = self.childNode(withName: "heightLabel") as! SKLabelNode
        timeLabel = self.childNode(withName: "timeLabel") as! SKLabelNode
        highscoreLabel = self.childNode(withName: "highscoreLabel") as! SKLabelNode
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        endScore.isHidden = true
        highscoreLabel.isHidden = true
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if block1.contains(location) {
                block1.run(SKAction.move(to: location, duration: 0))
            } else if block2.contains(location) {
                block2.run(SKAction.move(to: location, duration: 0))
            } else if block3.contains(location) {
                block3.run(SKAction.move(to: location, duration: 0))
            } else if block4.contains(location) {
                block4.run(SKAction.move(to: location, duration: 0))
            } else if long1.contains(location) {
                long1.run(SKAction.move(to: location, duration: 0))
            } else if long2.contains(location) {
                long2.run(SKAction.move(to: location, duration: 0))
            } else if longest1.contains(location) {
                longest1.run(SKAction.move(to: location, duration: 0))
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        height = ball.position.y + 548
        height = height.rounded()
        ballHeight.text = height.description
        
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)s"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            endScore.text = "You Scored " + height.description
            endScore.isHidden = false
            
            var arrayOfStrings: [String] = []
            do {
                let path = Bundle.main.path(forResource: "leaderboard", ofType: "txt")
                if path != nil {
                    let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                    arrayOfStrings = data.components(separatedBy: "\n")
                } else {
                    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let fileURL = DocumentDirURL.appendingPathComponent("leaderboard").appendingPathExtension("txt")
                    let data = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
                    arrayOfStrings = data.components(separatedBy: "\n")
                }
            } catch let error as NSError {
                print(error)
            }
            var highscore = Float(0)
            if arrayOfStrings.count > 0{
                highscore = Float(arrayOfStrings[0])!
            } else {
                highscore = Float(height)
            }
            
            if  highscore < Float(height) {
                let file = "leaderboard"
                highscoreLabel.isHidden = false
                let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let fileURL = DocumentDirURL.appendingPathComponent(file).appendingPathExtension("txt")
                do {
                    try ballHeight.text!.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                } catch { print(error) }
            }
            
        } else if timeLeft <= 10 {
            timeLabel.fontColor = UIColor.red
        }
    }
    
    func getScore() ->Int {
        return Int(height)
    }
}
