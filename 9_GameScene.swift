//
//  GameScene.swift
//  tap tap game - sample 9
//
//  YouTube : https://youtu.be/i3y9GAvc3TI
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mainCharNode:SKSpriteNode = SKSpriteNode(imageNamed: "ossan.png")
    let gameOverLabel = SKLabelNode()
    
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
        
        gameOverLabel.text = "Game Over"
        self.gameOverLabel.fontSize = 128
        self.gameOverLabel.fontColor = UIColor.black
        self.gameOverLabel.alpha = 0
        self.addChild(gameOverLabel)
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
            self.gameOverLabel.alpha = 1 // 画面のゲームオーバー文字を表示
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
        // 当たり判定
        guard let node = self.childNode(withName: "fish") else { return }
        let nodes = self.nodes(at: node.position)
        if nodes.count > 1 {
            self.gameOverLabel.alpha = 1
        }
    }
    
    
    func addShark(){
        let shark = SKSpriteNode(imageNamed: "shark.png")
        let yPos = CGFloat(Int.random(in: 0 ..< Int(self.view!.frame.height))) - (self.view!.frame.height / 2)
        
        shark.name = "fish"
        shark.position = CGPoint(
            x:self.view!.frame.width * -1,
            y:yPos
        )
        self.addChild(shark)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width, duration: 3)
        shark.run(
            SKAction.sequence([moveAction, SKAction.removeFromParent()])
        )
        
        let sharkAttack = SKAction.run {
            //
            self.addShark()
        }
        let newSharkAction = SKAction.sequence([SKAction.wait(forDuration: 3), sharkAttack])
        self.run(newSharkAction)
        
    }
}
