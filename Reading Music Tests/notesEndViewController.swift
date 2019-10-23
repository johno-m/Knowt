//
//  notesEndViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 30/07/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class notesEndViewController: UIViewController {
    
    @IBOutlet weak var prog3lbl: UILabel!
    @IBOutlet weak var prog2lbl: UILabel!
    @IBOutlet weak var prog1lbl: UILabel!
    @IBOutlet weak var userLevelLabel1: UILabel!
    @IBOutlet weak var userLevelLabel2: UILabel!
    var userLevelLabelProg = UILabel()
    @IBOutlet weak var userLevelView: UILabel!
    @IBOutlet weak var progressText: UILabel!
    @IBOutlet weak var previousTarget: UILabel!
    @IBOutlet weak var nextTarget: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var promotionStar: UIImageView!
    
    @IBOutlet weak var prog3: KDCircularProgress!
    @IBOutlet weak var prog2: KDCircularProgress!
    @IBOutlet weak var prog1: KDCircularProgress!
    let mastered1 = UIImageView()
    let mastered2 = UIImageView()
    let mastered3 = UIImageView()
    
    var progList = [KDCircularProgress()]
    var totalScore = 0
    var timer = Timer()
    var isPromoted = false
    
    @IBAction func playAgainBtn(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorial2ViewController") as! notesTutorial2ViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        loadUserInf()
        loadTotalScore()
        progList = [prog3, prog2, prog1]
        userLevelLabel1.text = "\(userLevel[0])"
        userLevelLabel2.text = "\(userLevel[0] + 1)"
        prog1lbl.text = "\(noteNames[notesInGameTop3[0]] ?? "A")"
        prog2lbl.text = "\(noteNames[notesInGameTop3[1]] ?? "B")"
        prog3lbl.text = "\(noteNames[notesInGameTop3[2]] ?? "C")"
        print("Top 3 are... : \(notesInGameTop3)")
        if userLevel[0] == 0 {
            previousTarget.text = "0"
        } else {
            previousTarget.text = "\(userLevelTargets[userLevel[0]-1])"
        }
        nextTarget.text = "\(userLevelTargets[userLevel[0]])"
        currentScore.text = "\(totalScore)"
        self.currentScore.alpha = 0
        if totalScore > userLevelTargets[userLevel[0]] {
            print("score target reached. User on next level!")
            saveUserInf()
            isPromoted = true
        } else {
            print("score limit not reached.")
            isPromoted = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var i = 0
        showLevelProgress()
        for progBar in progList {
            var score = Float(0)
            if allNotes[notesInGameTop3[i]]! < 100 {
                score = Float(allNotes[notesInGameTop3[i]]!) / Float(100)
            } else {
                score = Float(1)
            }
            let newAngleValue = 360*score
            progBar.animate(toAngle: Double(newAngleValue), duration: 1, completion: nil)
            i += 1
            
        }
        if allNotes[notesInGameTop3[0]]! > 99 {
            let newWidth = prog1.frame.width * 0.8
            mastered1.frame = CGRect(x: 0, y: 0, width: newWidth, height: newWidth * 0.27067669)
            mastered1.image = UIImage(named: "mastered.png")
            mastered1.center = prog1.center
            mastered1.alpha = 0
            prog1.addSubview(mastered1)
            UIView.animate(withDuration: 2, delay:2, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                self.mastered1.frame.origin.y += (self.prog2.frame.height / 2.5)
                self.mastered1.alpha = 0.7
            }, completion: { finished in
                
            })
        }
        if allNotes[notesInGameTop3[1]]! > 99 {
            let newWidth = prog2.frame.width * 0.8
            mastered2.frame = CGRect(x: 0, y: 0, width: newWidth, height: newWidth * 0.27067669)
            mastered2.image = UIImage(named: "mastered.png")
            mastered2.center = prog2.center
            mastered2.alpha = 0
            prog2.addSubview(mastered2)
            UIView.animate(withDuration: 2, delay:2, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                self.mastered2.frame.origin.y += (self.prog2.frame.height / 2.5)
                self.mastered2.alpha = 0.7
            }, completion: { finished in
                
            })
        }
        if allNotes[notesInGameTop3[2]]! > 99 {
            let newWidth = prog3.frame.width * 0.8
            mastered3.frame = CGRect(x: 0, y: 0, width: newWidth, height: newWidth * 0.27067669)
            mastered3.image = UIImage(named: "mastered.png")
            mastered3.center = prog2.center
            mastered3.alpha = 0
            prog3.addSubview(mastered3)
            UIView.animate(withDuration: 2, delay:2, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                self.mastered3.frame.origin.y += (self.prog2.frame.height / 2.5)
                self.mastered3.alpha = 0.7
            }, completion: { finished in
                
            })
        }
        
        //increase players score now everything is done.
        if isPromoted {
            print("Promoting user")
            userLevel[0] += 1
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadTotalScore(){
        for note in noteList {
            totalScore = allNotes[note]! + totalScore
        }
    }
    
    func showLevelProgress(){
        var previousTarget = 0
        let currentTarget = userLevelTargets[userLevel[0]]
        if userLevel[0] > 0 {
            previousTarget = userLevelTargets[userLevel[0]-1]
            print("User level is: \(userLevel[0]) - The previous target was \(previousTarget) the current target is \(currentTarget) and the total score is \(totalScore)")
        }
        
        userLevelLabelProg.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        userLevelLabelProg.backgroundColor = UIColor.white
        userLevelView.addSubview(userLevelLabelProg)
        
        // this is how many points we need to get in this level to reach the next stage.
        let progressFullValue = currentTarget - previousTarget
        
        let progressBarValue = totalScore - previousTarget
        var progressBarMaths = CGFloat(progressBarValue) / CGFloat(progressFullValue)
        if (progressBarMaths > 1) {
            progressBarMaths = 1
        }
        let progressBarWidth = progressText.frame.size.width * progressBarMaths
        
        //check to see if the user has reached the next level and start the animation to make the promotion star appear
        if self.isPromoted {
            UIView.animate(withDuration: 2, delay:1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.currentScore.center.x = progressBarWidth + self.userLevelView.frame.origin.x
                self.currentScore.alpha = 1
                let cutOff = self.nextTarget.frame.origin.x - 40
                if self.currentScore.center.x > cutOff {
                    self.currentScore.alpha = 0
                }
            }, completion: { finished in
                print(progressBarWidth)
                self.shakeNote(target: self.userLevelLabel2)
            })
        }
        
        UIView.animate(withDuration: 2, delay:1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.userLevelLabelProg.frame.size.width = progressBarWidth
            
        }, completion: { finished in
        })
    }
    
    func shakeNote(target: UILabel){
        let radians = CGFloat(Double.pi / 50)
        let radians2 = CGFloat(-0.1)
        UIView.animate(withDuration: 0.1, delay:0, animations: {
            target.transform = CGAffineTransform.identity.rotated(by: radians).scaledBy(x:1.5, y: 1.5)
            self.promotionStar.alpha = 1
            self.nextTarget.alpha = 0
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, delay:0, animations: {
                target.transform = CGAffineTransform(rotationAngle: radians2)
            }, completion: { finished in
                UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                    target.transform = CGAffineTransform.identity.rotated(by: 0).scaledBy(x:1.5, y: 1.5)
                    
                }, completion: { finished in
                    
                    self.callTimer()
                    
                })
            })
        })
    }
    
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.shakeNote2), userInfo: nil, repeats: true)

    }
    
    @objc func shakeNote2(){
        let target:UILabel = userLevelLabel2!
        let radians = CGFloat(Double.pi / 50)
        let radians2 = CGFloat(-0.1)
        UIView.animate(withDuration: 0.1, delay:0, animations: {
            target.transform = CGAffineTransform.identity.rotated(by: radians).scaledBy(x:1.5, y: 1.5)
            self.promotionStar.alpha = 1
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, delay:0, animations: {
                target.transform = CGAffineTransform.identity.rotated(by: radians2).scaledBy(x:1.4, y: 1.4)
            }, completion: { finished in
                UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                    target.transform = CGAffineTransform.identity.rotated(by: 0).scaledBy(x:1.5, y: 1.5)
                    
                }, completion: { finished in
                    
                })
            })
        })
    }
    
}
