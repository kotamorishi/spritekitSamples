//
//  GameScene.swift
//  tap tap game - sample 1
//
//  YouTube : https://youtube.com/
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mainCharNode:SKSpriteNode = SKSpriteNode(imageNamed: "ossan.png")
    
    override func didMove(to view: SKView) {
        // このシーンが表示されるタイミングで呼び出される
        // 主に初期化処理に使う
        print("[debug] didMove - called.")
        
        
        // SKSpriteNode
        self.mainCharNode.alpha = 1 // 0 ~ 1
        self.mainCharNode.position = CGPoint(x: 200, y: view.frame.height / -2 + 100)
        self.addChild(self.mainCharNode)
        
        self.backgroundColor = UIColor.white
        self.addShark()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let movePos = CGPoint(x: self.mainCharNode.position.x, y: self.mainCharNode.position.y + 200)
        let jumpUpAction = SKAction.move(to: movePos, duration: 0.2)
        jumpUpAction.timingMode = .easeInEaseOut
        let jumpDownAction = SKAction.move(to: self.mainCharNode.position, duration: 0.2)
        jumpDownAction.timingMode = .easeInEaseOut
        
        let jumpActions = SKAction.sequence([jumpUpAction, jumpDownAction ])
        
        self.mainCharNode.run(jumpActions)
        
        // gameover check
        if self.isGameOver() == true {
            let gameOverLabel = SKLabelNode()
            gameOverLabel.text = "Game Over"
            gameOverLabel.fontSize = 128
            gameOverLabel.fontColor = UIColor.black
            self.addChild(gameOverLabel)
        }
        
    }
    
    /**
     Game over check
     
     true : game over
     false : still okay
     */
    func isGameOver() -> Bool {
        // screen pos 80% > char pos
        // self.view!.frame.height // 画面のサイズ（高さ）
        if self.mainCharNode.position.y > self.view!.frame.height / 2 - 100 {
            return true
        }
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチしている指が移動した時に呼ばれる
        print("[debug] touchesMoved - called.")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 画面から指が離れた時に呼ばれる
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチ処理が継続出来ずに終了した時に呼び出される
        // 基本的に touchesEnded と同様の処理を行う
    }
    

    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    func addShark(){
        let shark = SKSpriteNode(imageNamed: "shark.png")
        let yPos = CGFloat(Int.random(in: 0 ..< Int(self.view!.frame.height))) - (self.view!.frame.height / 2)
            
        shark.position = CGPoint(
            x:self.view!.frame.width * -1,
            y:yPos
        )
        self.addChild(shark)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width, duration: 1)
        shark.run(moveAction)
        
        
        let sharkAttack = SKAction.run {
            //
            self.addShark()
        }
        let newSharkAction = SKAction.sequence([SKAction.wait(forDuration: 1), sharkAttack])
        self.run(newSharkAction)
        
    }
}
