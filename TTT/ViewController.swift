//
//  ViewController.swift
//  TTT
//
//  Created by Sheetal Desai on 11/1/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelWinner: UILabel!
    
    
    @IBOutlet var buttons: [UIButton]!
    
    var players = ["player1","player2"]
    var colors = ["player1":UIColor.green,"player2":UIColor.yellow,"default":UIColor.gray]
    var currentPlayer = ""
    var clicked = Dictionary<String,[UIButton]>()
    var scores = ["row1":0,"row2":0,"row3":0,"col1":0,"col2":0,"col3":0, "dig1":0, "dig2":0]
    var gameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {

        if (gameOver) {
            return
        }
        labelWinner.text = "\(currentPlayer)"
        if var player = clicked[currentPlayer] {
            print("Adding \(sender.tag) to clicked for \(currentPlayer)")
            clicked[currentPlayer]!.append(sender)
        }
        else {
            let arr:[UIButton] = [sender]
            print("Adding \(sender.tag) to clicked for \(currentPlayer)")
            clicked[currentPlayer] = arr
        }
        
        updateScore(senderid:sender.tag)
        
        sender.backgroundColor = colors[currentPlayer]
        sender.isEnabled = false;
        
        if currentPlayer == players[0] {
            currentPlayer = players[1]
        }
        else {
            currentPlayer = players[0]
        }
        
        if let winner = isWinner() {
            labelWinner.text = "Congratulations \(winner) won!!"
            labelWinner.textColor = UIColor.orange
            gameOver = true
        }
        
    }
    
    
    @IBAction func resetPressed(_ sender: UIButton) {
        print("Reset clicked")
        setDefaults()
    }
    
    func setDefaults () {
        for button in buttons {
            button.backgroundColor = UIColor.gray
            button.isEnabled = true
        }
        currentPlayer = players[0]
        labelWinner.text = "Playing \(currentPlayer)"
        gameOver = false
        for (key,val) in scores {
            print ("\(key) \(val)")
            scores[key] = 0
        }
        
    }
    
    func isWinner() -> String! {
        for (key,val) in scores {
            print("\(key) \(val)")
            if val == 3 {
                return players[0]
            }
            else if val == -3 {
                return players[1]
            }
        }
        return nil
    }
    
    func updateScore(senderid: Int) {
        let rcd = getRowColDig(tag:senderid)
        var updateScoreBy = 0
        if currentPlayer == players[0] {
            print("Updating score by 1 \(currentPlayer)")
            updateScoreBy = 1
        }
        else {
            print("Updating score by -1 \(currentPlayer)")
            updateScoreBy = -1
        }
        scores[rcd.0]! += updateScoreBy
        scores[rcd.1]! += updateScoreBy
        if rcd.2 != "" {
            if rcd.2 != "dig1dig2" {
                scores[rcd.2]! += updateScoreBy
            }
            else {
                scores["dig1"]! += updateScoreBy
                scores["dig2"]! += updateScoreBy
            }
        }
    }
    
    func getRowColDig(tag:Int) ->(row:String, col:String, dig:String) {
        var rcd:(String,String,String)
        switch tag {
        case 0:
            rcd = ("row1","col1","dig1")
            return rcd
        case 1:
            rcd = ("row1","col2","")
            return rcd
        case 2:
            rcd = ("row1","col3","dig2")
            return rcd
        case 3:
            rcd = ("row2","col1","")
            return rcd
        case 4:
            rcd = ("row2","col2","dig1dig2")
            return rcd
        case 5:
            rcd = ("row2","col3","")
            return rcd
        case 6:
            rcd = ("row3","col1","dig2")
            return rcd
        case 7:
            rcd = ("row3","col2","")
            return rcd
        case 8:
            rcd = ("row3","col3","dig1")
            return rcd
        default:
            rcd = ("","","")
            return rcd
        }
    }
}

