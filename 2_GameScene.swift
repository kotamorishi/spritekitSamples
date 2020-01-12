//
//  GameScene.swift
//  tap tap game - sample 1
//
//  YouTube : https://youtube.com/
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        // このシーンが表示されるタイミングで呼び出される
        // 主に初期化処理に使う
        print("[debug] didMove - called.")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 画面をタッチ開始した時に呼ばれる
        var counter:Int = 0
        counter = counter + 1
        print("[debug] touchesBegan - called first")
        print("[debug] touchesBegan - called second")
        
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
