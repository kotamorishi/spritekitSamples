//
//  GameScene.swift
//  tap tap game - sample 
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
        print("[debug] touchesEnded - \(updateCounter)")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチ処理が継続出来ずに終了した時に呼び出される
        // 基本的に touchesEnded と同様の処理を行う
    }
    
    var updateCounter:Int = 0
    override func update(_ currentTime: TimeInterval) {
        
        updateCounter = updateCounter + 1
        
        // ゲームが60fpsで動作している時、１秒間に６０回呼び出される。
        // 負荷などの理由により必ず同じタイミングで呼び出される訳ではないので引数の　currentTime　の差分だけ処理をする。
    }
}
