//
//  rhythmGame2ViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 12/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class rhythmGame2ViewController: UIViewController {

    @IBOutlet weak var loadCover: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var staveImg: UIImageView!
    @IBOutlet weak var spot1: UIButton!
    @IBOutlet weak var spot2: UIButton!
    @IBOutlet weak var spot3: UIButton!
    @IBOutlet weak var spot4: UIButton!
    @IBOutlet weak var spot5: UIButton!
    @IBOutlet weak var spot6: UIButton!
    @IBOutlet weak var spot7: UIButton!
    @IBOutlet weak var spot8: UIButton!
    @IBOutlet weak var rhythmCountImg1: UIImageView!
    @IBOutlet weak var rhythmCountImg2: UIImageView!
    @IBOutlet weak var rhythmCountImg3: UIImageView!
    @IBOutlet weak var rhythmCountImg4: UIImageView!
    @IBOutlet weak var rhythmCountImg5: UIImageView!
    @IBOutlet weak var rhythmCountImg6: UIImageView!
    @IBOutlet weak var rhythmCountImg7: UIImageView!
    @IBOutlet weak var rhythmCountImg8: UIImageView!
    @IBOutlet weak var rhythmAnswer1: UIImageView!
    @IBOutlet weak var rhythmAnswer2: UIImageView!
    @IBOutlet weak var rhythmAnswer3: UIImageView!
    @IBOutlet weak var rhythmAnswer4: UIImageView!
    @IBOutlet weak var rhythmAnswer7: UIImageView!
    @IBOutlet weak var rhythmAnswer5: UIImageView!
    @IBOutlet weak var rhythmAnswer6: UIImageView!
    @IBOutlet weak var rhythmAnswer8: UIImageView!
    var correctButtonIndex = UIButton()
    var selectedAnswer = UIButton()
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var nextLoading: UILabel!
    
    @IBAction func answerClicked(_ sender: UIButton) {
        resetScreen()
        selectedAnswer = sender
        switch sender.tag {
        case 1:
            rhythmAnswer1.alpha = 1
        case 2:
            rhythmAnswer2.alpha = 1
        case 3:
            rhythmAnswer3.alpha = 1
        case 4:
            rhythmAnswer4.alpha = 1
        case 5:
            rhythmAnswer5.alpha = 1
        case 6:
            rhythmAnswer6.alpha = 1
        case 7:
            rhythmAnswer7.alpha = 1
        case 8:
            rhythmAnswer8.alpha = 1
        default:
            print("No spot chosen")
        }
        userButton.isEnabled = true
    }
    
    @IBAction func checkAnswer(_ sender: Any) {
        resetScreen()
        userButton.isEnabled = false
        rhythmCountImg1.alpha = 1
        rhythmCountImg2.alpha = 1
        rhythmCountImg3.alpha = 1
        rhythmCountImg4.alpha = 1
        rhythmCountImg5.alpha = 1
        rhythmCountImg6.alpha = 1
        rhythmCountImg7.alpha = 1
        rhythmCountImg8.alpha = 1
        if correctButtonIndex == selectedAnswer {
            // correct
            correctButtonIndex.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            rhythmGameScore += 1
            userButton.setTitle("Correct!", for: .normal)
            userButton.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        } else {
            // incorrect
            userButton.setTitle("Incorrect!", for: .normal)
            userButton.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            correctButtonIndex.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            selectedAnswer.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            switch correctButtonIndex {
            case spot1:
                rhythmAnswer1.alpha = 1
            case spot2:
                rhythmAnswer2.alpha = 1
            case spot3:
                rhythmAnswer3.alpha = 1
            case spot4:
                rhythmAnswer4.alpha = 1
            case spot5:
                rhythmAnswer5.alpha = 1
            case spot6:
                rhythmAnswer6.alpha = 1
            case spot7:
                rhythmAnswer7.alpha = 1
            case spot8:
                rhythmAnswer8.alpha = 1
            default:
                print("Error")
            }
            print(selectedAnswer)
            print(spot1)
            switch selectedAnswer {
            case spot1:
                rhythmAnswer1.image = UIImage(named:"cross.png")
                rhythmAnswer1.alpha = 1
            case spot2:
                rhythmAnswer2.image = UIImage(named:"cross.png")
                rhythmAnswer2.alpha = 1
            case spot3:
                rhythmAnswer3.image = UIImage(named:"cross.png")
                rhythmAnswer3.alpha = 1
            case spot4:
                rhythmAnswer4.image = UIImage(named:"cross.png")
                rhythmAnswer4.alpha = 1
            case spot5:
                rhythmAnswer5.image = UIImage(named:"cross.png")
                rhythmAnswer5.alpha = 1
            case spot6:
                rhythmAnswer6.image = UIImage(named:"cross.png")
                rhythmAnswer6.alpha = 1
            case spot7:
                rhythmAnswer7.image = UIImage(named:"cross.png")
                rhythmAnswer7.alpha = 1
            case spot8:
                rhythmAnswer8.image = UIImage(named:"cross.png")
                rhythmAnswer8.alpha = 1
            default:
                print("Error")
            }
        }
        print("Calling animation")
        UIView.animate(withDuration: 2, animations: {
            self.nextLoading.frame.size.width = self.userButton.frame.width
        }, completion: { finished in
            if(finished){
                self.endRound()
            }
        })
    }
    
    func endRound(){
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
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesSplashViewController") as! notesSplashViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func fillScreen(question: String, answer: Int, imgURL: String, arrowLoc: String, beatCountArray: [Int]){
        rhythmCountImg1.image = UIImage(named: "")
        rhythmCountImg2.image = UIImage(named: "")
        rhythmCountImg3.image = UIImage(named: "")
        rhythmCountImg4.image = UIImage(named: "")
        rhythmCountImg5.image = UIImage(named: "")
        rhythmCountImg6.image = UIImage(named: "")
        rhythmCountImg7.image = UIImage(named: "")
        rhythmCountImg8.image = UIImage(named: "")
        
        for item in beatCountArray {
            if item == 1 {
                rhythmCountImg1.image = UIImage(named: "beatCount_01.png")
            }
            if item == 2 {
                rhythmCountImg2.image = UIImage(named: "beatCount_02.png")
            }
            if item == 3 {
                rhythmCountImg3.image = UIImage(named: "beatCount_03.png")
            }
            if item == 4 {
                rhythmCountImg4.image = UIImage(named: "beatCount_04.png")
            }
            if item == 5 {
                rhythmCountImg5.image = UIImage(named: "beatCount_05.png")
            }
            if item == 6 {
                rhythmCountImg6.image = UIImage(named: "beatCount_06.png")
            }
            if item == 7 {
                rhythmCountImg7.image = UIImage(named: "beatCount_07.png")
            }
            if item == 8 {
                rhythmCountImg8.image = UIImage(named: "beatCount_08.png")
            }
            
        }
        var arrowLoc2 = UIImageView()
        if arrowLoc == "rhythmAnswer1" {
            arrowLoc2 = rhythmAnswer1
        }
        if arrowLoc == "rhythmAnswer2" {
            arrowLoc2 = rhythmAnswer2
        }
        if arrowLoc == "rhythmAnswer3" {
            arrowLoc2 = rhythmAnswer3
        }
        if arrowLoc == "rhythmAnswer4" {
            arrowLoc2 = rhythmAnswer4
        }
        if arrowLoc == "rhythmAnswer5" {
            arrowLoc2 = rhythmAnswer5
        }
        if arrowLoc == "rhythmAnswer6" {
            arrowLoc2 = rhythmAnswer6
        }
        if arrowLoc == "rhythmAnswer7" {
            arrowLoc2 = rhythmAnswer7
        }
        if arrowLoc == "rhythmAnswer8" {
            arrowLoc2 = rhythmAnswer8
        }
        arrowLoc2.image = UIImage(named: "arrow.png")
        staveImg.image = UIImage(named: imgURL)
        questionLabel.text = question
        switch answer {
        case 1:
            correctButtonIndex = spot1
        case 2:
            correctButtonIndex = spot2
        case 3:
            correctButtonIndex = spot3
        case 4:
            correctButtonIndex = spot4
        case 5:
            correctButtonIndex = spot5
        case 6:
            correctButtonIndex = spot6
        case 7:
            correctButtonIndex = spot7
        case 8:
            correctButtonIndex = spot8
        default:
            print("Error - no rhythm Answer selected")
        }
    }

    func resetScreen(){
        rhythmCountImg1.alpha = 0
        rhythmCountImg2.alpha = 0
        rhythmCountImg3.alpha = 0
        rhythmCountImg4.alpha = 0
        rhythmCountImg5.alpha = 0
        rhythmCountImg6.alpha = 0
        rhythmCountImg7.alpha = 0
        rhythmCountImg8.alpha = 0
        rhythmAnswer1.alpha = 0
        rhythmAnswer2.alpha = 0
        rhythmAnswer3.alpha = 0
        rhythmAnswer4.alpha = 0
        rhythmAnswer5.alpha = 0
        rhythmAnswer6.alpha = 0
        rhythmAnswer7.alpha = 0
        rhythmAnswer8.alpha = 0
        rhythmAnswer1.image = UIImage(named:"arrow.png")
        rhythmAnswer2.image = UIImage(named:"arrow.png")
        rhythmAnswer3.image = UIImage(named:"arrow.png")
        rhythmAnswer4.image = UIImage(named:"arrow.png")
        rhythmAnswer5.image = UIImage(named:"arrow.png")
        rhythmAnswer6.image = UIImage(named:"arrow.png")
        rhythmAnswer7.image = UIImage(named:"arrow.png")
        rhythmAnswer8.image = UIImage(named:"arrow.png")
    }
    
    func playRound(){
        rhythmRound += 1
        if rhythmRound < 8 {
            resetScreen()
            chooseQuestion()
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
    
    func chooseQuestion(){
        var questionChoice = 0
        if userLevel[2] == 0 {
            questionChoice = 12
        }
        if userLevel[2] == 1 {
            questionChoice = 18
        }
        if userLevel[2] == 2 {
            questionChoice = 24
        }
        let rand = Int(arc4random_uniform(UInt32(questionChoice)))
        let question:String = String(rhythmTestList[rand][0])
        let answer:Int = Int(rhythmTestList[rand][1])!
        let imgURL:String = String(rhythmTestList[rand][2])
        let arrowLoc:String = String(rhythmTestList[rand][3])
        
        fillScreen(question: question, answer: answer, imgURL: imgURL, arrowLoc: arrowLoc, beatCountArray: beatCountArr[rand])
        
        print("Question: \(rhythmTestList[rand][0]), Answer index: \(rhythmTestList[rand][1]), Rhythm Image: \(rhythmTestList[rand][2]), Correct Button: \(rhythmTestList[rand][3]), Beat list \(beatCountArr[rand])")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextLoading.translatesAutoresizingMaskIntoConstraints = true
        nextLoading.frame.size.width = 0
        userButton.isEnabled = false
        resetScreen()
        loadCover.alpha = 1
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playRound()
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
