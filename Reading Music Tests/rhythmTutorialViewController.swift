//
//  rhythmTutorialViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 09/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class rhythmTutorialViewController: UIViewController {

    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var tutorialImage: UIImageView!
    var tutorialArray = [String]()
    var questionsInGame = [[String]]()
    var tutorialQuestions = [[String]]()
    var tutorialCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //loadTutorial()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startRhythmGame()
    }
    
    func loadTutorial(){
        let rhythmLevel = userLevel[2]
        let rhythmLessonScope = rhythmDifficulty[rhythmLevel]
        var i = 0
        while i < rhythmLessonScope {
            questionsInGame.append(rhythmQuestions[i])
            i+=1
        }
        i = 0
        while i < questionsInGame.count {
            if rhythmScores[i] < 1 {
                tutorialQuestions.append(questionsInGame[i])
            }
            i+=1
            
        }
        playTutorial(count: tutorialCount)
    }
    @IBAction func tutorialButtonPressed(_ sender: Any) {
        tutorialButton.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.tutorialImage.alpha = 0.0
        }, completion: {
            (finished: Bool) -> Void in
            self.tutorialCount += 1
            self.playTutorial(count: self.tutorialCount)
        })
        
    }
    
    func playTutorial(count: Int){
        print("Playing next tutorial screen: \(count) out of \(tutorialQuestions.count)")
        tutorialButton.isHidden = false
        if count < tutorialQuestions.count {
            let imageSrc = "\(tutorialQuestions[count][3]).png"
            tutorialImage.alpha = 0
            tutorialImage.image = UIImage(named: imageSrc)
            UIView.animate(withDuration: 1, animations: {
                self.tutorialImage.alpha = 100.0
            }, completion: {
                (finished: Bool) -> Void in
                self.tutorialButton.isHidden = false
            })
        } else {
            playOut()
        }
    }
    
    func playOut(){
        tutorialImage.image = UIImage(named: "rhythm-gameLoading.png")
        UIView.animate(withDuration: 1, animations: {
            self.tutorialImage.alpha = 100.0
        })
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.startRhythmGame()
        }

    }
    
    func startRhythmGame(){
        rhythmRound = 0
        rhythmGameScore = 0
        rhythmGame1count = 0
        rhythmGame2count = 0
        rhythmGame3count = 0
        game1pool = [Int]()
        game2pool = [Int]()
        
        let rand = Int(arc4random_uniform(UInt32(3)))
        print("Starting game. Random number  = \(rand)")
        if rand == 0 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame1ViewController") as! rhythmGame1ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        if rand == 1 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame2ViewController") as! rhythmGame2ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        if rand == 2 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame3ViewController") as! rhythmGame3ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
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
