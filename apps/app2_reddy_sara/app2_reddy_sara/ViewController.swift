//
//  ViewController.swift
//  app2_reddy_sara
//
//  Created by Sara Reddy on 9/16/20.
//  Copyright © 2020 Sara Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var score_p2: UILabel!
    @IBOutlet weak var score_p1: UILabel!
    var turn = true; //true = p1 turn
    var gameBoard = [0,0,0,0,0,0,0,0,0]
    var p1Score = 0
    var p2Score = 0
    var status = GameStatus.play
    let win = [[0, 1, 2],
               [0, 3, 6],
               [0, 4, 8],
               [1, 4, 7],
               [2, 4, 6],
               [2, 5, 8],
               [3, 4, 5],
               [6, 7, 8]]
    
    enum GameStatus {
        case win,
        play,
        draw
    }
    @IBOutlet var collectionOfButtons: Array<UIButton> = Array<UIButton>()
    override func viewDidLoad() {
        super.viewDidLoad()
        score_p1.text = "P1: \(p1Score)"
        score_p2.text = "P2: \(p2Score)"
        gameStatus.text = "P1's Turn"
        for tile in collectionOfButtons {
            tile.tintColor = .systemBlue
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func updateBoard(_ sender: UIButton) {
        let tag = sender.tag
        if turn && status == GameStatus.play {
            if (gameBoard[tag - 1] != 0) {
                print("invalid Move \(tag)")
                gameStatus.text = "Invalid Move, P1's Turn"
            } else {
                sender.setImage(UIImage(named: "mark-x")?.withRenderingMode(.alwaysTemplate), for: .normal)
                gameBoard[tag - 1] = 1
                 print(sender.tag)
                 if (gameWin()) {
                     gameStatus.text = "P1 WINS"
                    gameStatus.textColor = UIColor.green
                 } else if (draw()) {
                    gameStatus.text = "Draw"
                } else {
                     gameStatus.text = "P2's Turn"
                     turn = false
                 }
            }
        } else if status == GameStatus.play {
            if (gameBoard[tag - 1] != 0) {
                print("invalid Move")
                gameStatus.text = "Invalid Move, P2's Turn"
            } else {
                sender.setImage(UIImage(named: "mark-o")?.withRenderingMode(.alwaysTemplate), for: .normal)
                print(sender.tag)
                gameBoard[tag - 1] = 2
                if (gameWin()) {
                    gameStatus.text = "P2 WINS"
                    gameStatus.textColor = UIColor.green
                } else if (draw()) {
                    gameStatus.text = "Draw"
                    
                }else {
                     gameStatus.text = "P1's Turn"
                     turn = true
                }
            }
        }
        score_p1.text = "P1: \(p1Score)"
        score_p2.text = "P2: \(p2Score)"
    }
    
    func gameWin() -> Bool{
        for w in win {
            if (turn) {
                if (gameBoard[w[0]] == 1 && gameBoard[w[1]] == 1 && gameBoard[w[2]] == 1) {
                    let button1 = self.view.viewWithTag(w[0] + 1)
                    button1?.tintColor = .systemYellow
                    let button2 = self.view.viewWithTag(w[1] + 1)
                    button2?.tintColor = .systemYellow
                    let button3 = self.view.viewWithTag(w[2] + 1)
                    button3?.tintColor = .systemYellow
                    p1Score += 1
                    status = GameStatus.win
                    return true
                }
            } else {
                if (gameBoard[w[0]] == 2 && gameBoard[w[1]] == 2 && gameBoard[w[2]] == 2) {
                    let button1 = self.view.viewWithTag(w[0] + 1)
                    button1?.tintColor = .systemYellow
                    let button2 = self.view.viewWithTag(w[1] + 1)
                    button2?.tintColor = .systemYellow
                    let button3 = self.view.viewWithTag(w[2] + 1)
                    button3?.tintColor = .systemYellow
                    p2Score += 1
                    status = GameStatus.win
                    return true
                }
            }
        }
        return false
    }
    
    func draw() -> Bool {
        var count = 0
        for x in gameBoard {
            if x != 0 {
                count += 1
            }
        }
        if count == 9 {
            for tile in collectionOfButtons {
                tile.tintColor = .systemGray
            }
            gameStatus.textColor = UIColor.gray
            status = GameStatus.draw
            return true
        }
        return false
    }

    
    @IBAction func clear(_ sender: UIButton) {
        for tile in collectionOfButtons {
            tile.setImage(UIImage(named: "mark-none"), for: .normal)
            tile.tintColor = .systemBlue
        }
        turn = true;
        gameStatus.text = "P1's Turn"
        for x in 0...8 {
            gameBoard[x] = 0
        }
        gameStatus.textColor = UIColor.black
        status = GameStatus.play
    }
    
    
}

