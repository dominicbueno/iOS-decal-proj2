//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var hangmanInputTextField: UITextField!
    @IBOutlet weak var incorrectLettersLabel: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var hangmanWordLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    
    var word: String!
    var incorrectGuesses: String!
    var guessChar: String!
    var guessedSet: String!
    var numCorrect: Int = 0
    var numLetters: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func initializeView() {

        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        self.guessChar = ""
        self.word = phrase!.lowercased()
        self.hangmanInputTextField.text = ""
        self.guessedSet = ""
        self.incorrectLettersLabel.text = ""
        self.incorrectGuesses = ""
        self.hangmanWordLabel.text = ""
        
        hangManInit(phrase!)
        hangmanInputTextField.delegate = self
        guessButton.addTarget(self, action: #selector(pressOfTheGuessButtonHappened), for: .touchUpInside)
    }
    
    func hangManInit (_ hangmanWord: String) {
        self.hangmanImage.image = UIImage(named: "hangman1.gif")
        
        self.numCorrect = hangmanWord.characters.count
        self.numLetters = 0
        for i in 0..<hangmanWord.characters.count {
            if hangmanWord.substring(atIndex: i) == " " {
                self.hangmanWordLabel.text! += " "
                self.numLetters += 1
            } else {
                self.hangmanWordLabel.text! += "-"
            }
        }
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let shouldShowLetter = ((textField.text?.characters.count ?? 0) + string.characters.count - range.length) <= 1 && string != " "
        if shouldShowLetter {
            guessChar = string
        }
        return shouldShowLetter
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 
        textField.resignFirstResponder()
        return true
    }
    

    func pressOfTheGuessButtonHappened() {
        self.checkHangmanLetter(guessChar!)
        guessChar = ""
        hangmanInputTextField.text = ""
    }
    

    func gameWin() {
        alert("Game WINNER")
    }
    
    func gameLost() {
        alert("LOSER :(")
    }
    
    func alert(_ alertTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: "The word was: \(self.word!)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: {action in
                self.initializeView()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    

    func checkHangmanLetter (_ letterToCheck: String) {
        let letterToCheck = letterToCheck.lowercased()
        if (guessedSet.range(of: letterToCheck) != nil) {
            return
        }
        guessedSet.append(letterToCheck)
        
        var isMatch = false
        
        if (self.word.contains(letterToCheck)){
            isMatch = true
        }
        
        if (isMatch){
            for i in 0..<self.word.characters.count {
                if (letterToCheck == word.substring(atIndex: i)) {
                    isMatch = true
                    let start = hangmanWordLabel.text!.startIndex
                    let index = hangmanWordLabel.text!.index(start, offsetBy: i)
                    hangmanWordLabel.text!.replaceSubrange(index...index, with: letterToCheck)
                    self.numLetters += 1
            
                }
            }
        }
        
        if (self.numLetters == self.numCorrect) {
            self.gameWin()
            
        }
        if (!isMatch) {
            if (self.incorrectGuesses.range(of: letterToCheck) == nil) {
                self.incorrectGuesses.append(letterToCheck)
                self.incorrectLettersLabel.text! = incorrectGuesses
            }
            
            let wrongNum: Int = incorrectGuesses.characters.count;
            
            self.hangmanImage.image = UIImage(named: "hangman" + String(wrongNum + 1) + ".gif")
            if (wrongNum == 6) {
                self.gameLost()
                
            }
            
        }
    }

    


}
