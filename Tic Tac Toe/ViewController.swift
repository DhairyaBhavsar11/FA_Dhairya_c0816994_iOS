//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by dhairya bhavsar on 2022-05-13.
//

import UIKit

class ViewController: UIViewController
{
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var ScoreX: UILabel!
    @IBOutlet weak var ScoreO: UILabel!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkForVictory(CROSS)
        {
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
            ScoreX.text = "Score X : \(crossesScore)"
        }
        
        if checkForVictory(NOUGHT)
        {
            noughtsScore += 1
            resultAlert(title: "Noughts Win!")
            ScoreO.text = "Score 0 : \(noughtsScore)"
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
       
        
        if motion == .motionShake{
            
            print("Shake Gesture Recognized !!")
            
           checkForUndo()
            
            
            if(currentTurn == Turn.Nought)
            {
                
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
                
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
                
            
            
            
        }
       
        
    }
    
    func checkForVictory(_ s :String) -> Bool
    {
        // Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }
        
        return false
    }
    
    
    func checkForUndo()
    {
        
        for button in board
        {
            if button == a1
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == a2
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == a3
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == b1
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == b2
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == b3
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == c1
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == c2
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == c3
            {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            
        }
        
     /*   if thatSymbol(a1)
        {
            a1.setTitle("", for: .normal)
        }
        if thatSymbol(a2)
        {
            a2.setTitle("", for: .normal)
        }
        if thatSymbol(a3)
        {
            a3.setTitle("", for: .normal)
        }
        if thatSymbol(b1)
        {
            b1.setTitle("", for: .normal)
        }
        if thatSymbol(b2)
        {
            b2.setTitle("", for: .normal)
        }
        if thatSymbol(b3)
        {
            b3.setTitle("", for: .normal)
        }
        if thatSymbol(c1)
        {
            c1.setTitle("", for: .normal)
        }
        if thatSymbol(c2)
        {
            c2.setTitle("", for: .normal)
        }
        if thatSymbol(c3)
        {
            c3.setTitle("", for: .normal)
        }*/
        
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func thatSymbol(_ button: UIButton) -> Bool
    {
        return (button.title(for: .normal) != nil)
    }
    
    
    
    
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
  
}


