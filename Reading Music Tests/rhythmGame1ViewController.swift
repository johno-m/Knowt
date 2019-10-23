//
//  rhythmGame1ViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 12/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class rhythmGame1ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var loadCover: UILabel!
    
    var correctNoteIndex = 0
    
    @IBAction func buttonClicked(_ sender: Any) {
        let clickedTag:Int = (sender as AnyObject).tag
        print("Clicked: \(clickedTag))")
        if clickedTag == correctNoteIndex {
            playCorrectSeq(sender: sender as! UIButton)
            rhythmScores[correctNoteIndex] += 20
        } else {
            playIncorrectSeq(sender: sender as! UIButton)
            rhythmScores[correctNoteIndex] -= 20
            rhythmScores[clickedTag] -= 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button2.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button3.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        button4.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        loadCover.alpha = 1
        if rhythmGame1count == 0 {
            // first time
            selectNotesAndFillSelectionBucket()
            print(game1pool)
        }
        rhythmGame1count += 1
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playRound()
    }
    
    func playRound(){
        rhythmRound += 1
        if(rhythmRound < 8){
            selectCorrectAnswer()
            askQuestion()
            UIView.animate(withDuration: 1, animations: {
                self.loadCover.alpha = 0
            }, completion: { finished in
                if(finished){
                    self.loadCover.isHidden = true
                }
            })
        } else {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmEndViewController") as! rhythmEndViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func selectCorrectAnswer(){
        let rand = Int(arc4random_uniform(UInt32(game1pool.count)))
        correctNoteIndex = game1pool[rand]
        print("Correct note index is \(correctNoteIndex)")
    }
    
    func selectNotesAndFillSelectionBucket(){
        var i = 0
        var cumulativeScore = 0
        while i < rhythmDifficulty[userLevel[2]] {
            rhythmGame1NotesInGame.append(rhythmQuestions[i])
            i += 1
        }
        i = 0
        while i < rhythmGame1NotesInGame.count {
            
            cumulativeScore += rhythmScores[i]
            i += 1
        }
        i = 0
        while i < rhythmGame1NotesInGame.count {
            cumulativeScore += rhythmScores[i]
            let score = rhythmScores[i]
            print(cumulativeScore)
            var j:Int = 0
            if cumulativeScore == 0 || score == 0 {
                j = 100
            } else {
                j = Int(round(Double(100 - ((score / cumulativeScore) * 100))))
            }
            
            print(j)
            for _ in 0 ... j {
                game1pool.append(i)
            }
            i += 1
        }
        
    }

    func askQuestion(){
        
        // answerList is the pool of all possible answers including the correct one
        // buttonUnshuffled is the list of answers that will be presented to the user unshuffled. First is the correct answer.
        // As items are added to this they are removed from the answerList
        // items are then selected at random from buttonUnshuffled to be added to buttonShuffled then removed from buttonShuffled
        var answerList = [Int]()
        var buttonUnshuffled = [Int]()
        var buttonShuffled = [Int]()
        var i = 0
        
        while i < rhythmGame1NotesInGame.count {
            answerList.append(i)
            i+=1
        }
        answerList = answerList.filter { $0 != correctNoteIndex }
        
        buttonUnshuffled.append(correctNoteIndex)
        i = 0
        while i < 3 {
            print("Answer list = \(answerList)")
            let rand2 = Int(arc4random_uniform(UInt32(answerList.count)))
            buttonUnshuffled.append(answerList[rand2])
            answerList = answerList.filter { $0 != answerList[rand2] }
            i += 1
        }
        i = 0
        while i < 4 {
            let rand3 = Int(arc4random_uniform(UInt32(buttonUnshuffled.count)))
            buttonShuffled.append(buttonUnshuffled[rand3])
            buttonUnshuffled = buttonUnshuffled.filter { $0 != buttonUnshuffled[rand3] }
            i += 1
        }
        print(buttonShuffled)
        
        questionLabel.text = "Can you find the \(rhythmQuestions[correctNoteIndex][0])?"
        button1.setImage(UIImage(named: rhythmQuestions[buttonShuffled[0]][2]), for: .normal)
        button2.setImage(UIImage(named: rhythmQuestions[buttonShuffled[1]][2]), for: .normal)
        button3.setImage(UIImage(named: rhythmQuestions[buttonShuffled[2]][2]), for: .normal)
        button4.setImage(UIImage(named: rhythmQuestions[buttonShuffled[3]][2]), for: .normal)
        button1.tag = buttonShuffled[0]
        button2.tag = buttonShuffled[1]
        button3.tag = buttonShuffled[2]
        button4.tag = buttonShuffled[3]
    }

    func playCorrectSeq(sender: UIButton){
        let color1 = sender.backgroundColor
        UIView.animate(withDuration: 1, animations: {
            sender.backgroundColor = UIColor(red: 0, green: 100, blue: 0, alpha: 100.0)
        }, completion: {
            (finished: Bool) in
            UIView.animate(withDuration: 1, delay: 1, animations: {
                sender.backgroundColor = color1
            }, completion: {
                (finished: Bool) in
                self.loadNextGame()
            })
        })
    }
    
    func playIncorrectSeq(sender: UIButton){
        var correctButton = UIButton()
        switch correctNoteIndex {
        case 0:
            correctButton = button1
        case 1:
            correctButton = button2
        case 2:
            correctButton = button3
        case 3:
            correctButton = button4
        default:
            print("ERROR - NO CORRECT BUTTON SELECTED")
        }
        let color1 = correctButton.backgroundColor
        let color2 = sender.backgroundColor
        UIView.animate(withDuration: 1, animations: {
            
            sender.backgroundColor = UIColor(red: 100, green: 0, blue: 0, alpha: 100.0)
        }, completion: {
            (finished: Bool) in
            UIView.animate(withDuration: 1, animations: {
                correctButton.backgroundColor = UIColor(red: 0, green: 100, blue: 0, alpha: 100.0)
            }, completion: {
                (finished: Bool) in
                print("\(sender.tag) - \(correctButton.tag)")
                print(sender)
                self.returnToOriginalColors(color1: color1!, color2: color2!, right: correctButton, wrong: sender)
            })
        })
    }
    
    func returnToOriginalColors(color1: UIColor, color2: UIColor, right: UIButton, wrong: UIButton){
        UIView.animate(withDuration: 1, animations: {
            right.backgroundColor = color1
            wrong.backgroundColor = color2
        }, completion: { finished in
            if(finished){
                self.loadNextGame()
            }
        })
    }
    
    func loadNextGame(){
        let rand = Int(arc4random_uniform(9))
        print(" ")
        print("Load next game. Random num: \(rand)")
        print(" ")
        if rand < 3 {
            print("Load game 1")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame1ViewController") as! rhythmGame1ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        if rand > 2 && rand < 6 {
            print("Load game 2")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame2ViewController") as! rhythmGame2ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        if rand > 5 && rand < 9 {
            print("Load game 3")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame3ViewController") as! rhythmGame3ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
