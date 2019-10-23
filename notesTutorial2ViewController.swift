//
//  notesTutorial2ViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 31/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class notesTutorial2ViewController: UIViewController {

    var ray1 = UILabel()
    var ray2 = UILabel()
    var ray1Y = CGFloat()
    var ray2Y = CGFloat()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let sW = UIScreen.main.bounds.width
    let sH = UIScreen.main.bounds.height
    var allNotesInGame = [String()]
    var notesInTutorial = [String()]
    var tutorialCount = 0
    var roundNote = "E1"
    var okBtn = SpringButton()
    var finalNoteCards = [String()]
    
    //build lesson scene
    var lessonCont = SpringView()
    var testCont = SpringView()
    var lessonStave = UIImageView()
    var lessonNote = UIImageView()
    var lessonLedgerView = UIImageView()
    var lessonLabel = UILabel()
    
    // build tutorial scene
    var testScreen = SpringView()
    var testCard1 = SpringButton()
    var testCard2 = SpringButton()
    var testCard3 = SpringButton()
    var testLabel = UILabel()
    var choiceMade = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUserNotes = noteLevelList[usrInf.instrument]
        let numberOfLevels = (currentUserNotes?.count)! - 1
        print("number of Levels: \(numberOfLevels)")
        if(usrInf.treblelevel > numberOfLevels) {
            if usrInf.treblelevel > numberOfLevels {
                usrInf.treblelevel = numberOfLevels
            }
        } else {
            
        }
        drawButton()
        notesToLearn()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showRays()
        startAnim(target: ray1, toY: ray1Y, angle: -28.5)
        startAnim(target: ray2, toY: ray2Y, angle: -4.6)
        startRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Above this line are root functions
    
    func notesToLearn(){
        var i = 0
        let instrumentNoteLevels = noteLevelList[usrInf.instrument]
        let ceil = usrInf.treblelevel+1
        while i < ceil {
            for note in instrumentNoteLevels![i] {
                allNotesInGame.append(note)
            }
            i += 1
        }
        allNotesInGame.remove(at: 0)
        
        for note in allNotesInGame {
            print(note)
            if (trebleNotes[note]?.score)! < 1 {
                notesInTutorial.append(note)
            }
        }
        notesInTutorial.remove(at: 0)
        print("User Level: \(usrInf.treblelevel)")
        print("Notes that should be learnt: \(allNotesInGame)")
        print("Notes that need to be learnt: \(notesInTutorial)")
    }
    
    func startRound(){
        print("Starting tutorial rounds")
        if(tutorialCount < notesInTutorial.count){
            roundNote = notesInTutorial[tutorialCount]
            showLesson()
        } else {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
            
        }
        
    }
    
    func showLesson(){
        lessonCont.frame = CGRect(x: 0, y: 0, width: sW, height: sH)
        lessonStave.frame = CGRect(x: 0, y: sH*0.219, width: sW, height: sH*0.56)
        lessonLabel.frame = CGRect(x: 0, y: sH*0.15, width: sW, height: sH*0.2)
        lessonNote.frame = CGRect(x: 0, y: sH*0.15, width: sW*0.071, height: sH*0.56)
        lessonLedgerView.frame = CGRect(x: 0, y: sH*0.15, width: sW*0.071, height: sH*0.56)
        lessonNote.center = CGPoint(x: sW*0.5, y: sH*noteTutPos[roundNote]!)
        lessonLedgerView.center = CGPoint(x: sW*0.5, y: sH*0.5)
        lessonCont.isUserInteractionEnabled = false
        
        lessonNote.image = noteImage(note: roundNote)
        lessonStave.image = UIImage(named: "stave")
        print("This is \(notePrefix[roundNote]) '\(noteNames[roundNote])'")
        lessonLabel.text = "This is \(notePrefix[roundNote]!) '\(noteNames[roundNote]!)'"
        lessonLabel.textAlignment = .center
        lessonLabel.font = UIFont(name: "AmaticSC-Regular", size: 70)
        
        var isAltPos = checkAltPos(note: roundNote)
        
        showButton(altPos: isAltPos)
        
        self.view.addSubview(lessonCont)
        lessonCont.addSubview(lessonStave)
        lessonCont.addSubview(lessonLabel)
        lessonCont.addSubview(lessonNote)
        lessonCont.addSubview(lessonLedgerView)
        addLedgerLines(note: roundNote)
        lessonCont.alpha = 1
        lessonCont.animation = "squeezeDown"
        lessonCont.duration = 2
        lessonCont.curve = "spring"
        lessonCont.animate()
    }
    
    func endLessonAndStartTest(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.lessonCont.center = CGPoint(x: self.sW/2, y: self.sH*2)
            self.lessonCont.alpha = 0
        }, completion: { finished in
            self.lessonCont.removeFromSuperview()
            self.showTest()
        })
    }
    
    func endTestAndStartLesson(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.lessonCont.center = CGPoint(x: self.sW/2, y: self.sH*2)
            self.testScreen.alpha = 0
        }, completion: { finished in
            self.testScreen.removeFromSuperview()
            self.startRound()
        })
    }
    
    func showTest(){
        var wrongNotes = noteHints[roundNote]
        var cardNotes = [roundNote, wrongNotes![0], wrongNotes![1]]
        print(cardNotes)
        let rand = arc4random_uniform(6)
        if rand == 0 {
            cardNotes = [cardNotes[0], cardNotes[1], cardNotes[2]]
        }
        if rand == 1 {
            cardNotes = [cardNotes[1], cardNotes[0], cardNotes[2]]
        }
        if rand == 2 {
            cardNotes = [cardNotes[1], cardNotes[2], cardNotes[0]]
        }
        if rand == 3 {
            cardNotes = [cardNotes[2], cardNotes[1], cardNotes[0]]
        }
        if rand == 4 {
            cardNotes = [cardNotes[2], cardNotes[0], cardNotes[1]]
        }
        if rand == 5 {
            cardNotes = [cardNotes[0], cardNotes[2], cardNotes[1]]
        }
        finalNoteCards = cardNotes
        testScreen.frame = CGRect(x: 0, y: 0, width: sW, height: sH)
        testCard1.frame = CGRect(x: sW*0.083, y:sH*0.3, width: sW*0.254, height: sH*0.549)
        testCard1.setImage(UIImage(named: "tutTestCards\(cardNotes[0]).png"), for: .normal)
        testCard2.frame = CGRect(x: sW*0.374, y:sH*0.3, width: sW*0.254, height: sH*0.549)
        testCard2.setImage(UIImage(named: "tutTestCards\(cardNotes[1]).png"), for: .normal)
        testCard3.frame = CGRect(x: sW*0.663, y:sH*0.3, width: sW*0.254, height: sH*0.549)
        testCard3.setImage(UIImage(named: "tutTestCards\(cardNotes[2]).png"), for: .normal)
        
        testLabel.frame = CGRect(x:0, y: 0, width: sW, height: sH*0.2)
        testLabel.center = CGPoint(x: sW*0.5, y: sH*0.15)
        testLabel.text = "Which of these is \(notePrefix[roundNote]!) \(noteNames[roundNote]!)?"
        testLabel.textAlignment = .center
        testLabel.font = UIFont(name: "AmaticSC-Regular", size: 70)
        
        testCard1.tag = 0
        testCard2.tag = 1
        testCard3.tag = 2
        self.view.addSubview(testScreen)
        testScreen.addSubview(testCard1)
        testScreen.addSubview(testCard2)
        testScreen.addSubview(testCard3)
        testScreen.addSubview(testLabel)
        testCard1.addTarget(self, action: #selector(cardPressed), for: .touchUpInside)
        testCard2.addTarget(self, action: #selector(cardPressed), for: .touchUpInside)
        testCard3.addTarget(self, action: #selector(cardPressed), for: .touchUpInside)
        testScreen.alpha = 1
        testScreen.animation = "squeezeDown"
        testScreen.duration = 2
        testScreen.curve = "spring"
        testScreen.animate()
        
        choiceMade = false
    }
    
    @objc func cardPressed(sender: SpringButton!){
        if choiceMade {
            // do nothing
        } else {
            choiceMade = true
            if checkAnswer(clicked: sender.tag) {
                let image = UIImage(named: "tutTestCard_correct")
                sender.setImage(image, for: .normal)
                UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                tutorialCount += 1
                trebleNotes[roundNote]?.score += 1
                saveUserInf()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.endTestAndStartLesson()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let image = UIImage(named: "tutTestCard_incorrect")
                    sender.setImage(image, for: .normal)
                    UIView.transition(with: sender, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                    let correctCard = self.finalNoteCards.index(of: self.roundNote)
                    var target = self.testCard1
                    if correctCard == 0 { target = self.testCard1 }
                    if correctCard == 1 { target = self.testCard2 }
                    if correctCard == 2 { target = self.testCard3 }
                    target.animation = "wobble"
                    target.velocity = 0.05
                    target.damping = 0.9
                    target.duration = 1
                    target.delay = 1
                    target.curve = "easeIn"
                    target.animate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.endTestAndStartLesson()
                    }
                }
                
            }
            
        }
        
        
    }
    
    
    
    // *********** Below this line are completed functions (ish) ***************** //
    
    func checkAnswer(clicked: Int) -> Bool {
        var answer = false
        print("Clicked card was \(clicked)")
        if finalNoteCards[clicked] == roundNote {
            print("Correct one chosen!")
            answer = true
        } else {
            print("Incorrect one chosen!")
            answer = false
        }
        return answer
    }
    
    // show the OK button for the end of the Lesson slide.
    func showButton(altPos: Bool){
        
        okBtn.center = CGPoint(x: screenWidth/2, y: screenHeight*0.8)
        okBtn.alpha = 1
        okBtn.animation = "pop"
        okBtn.delay = 0
        okBtn.duration = 1
        okBtn.curve = "swing"
        okBtn.animate()
        
        if altPos == true {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.okBtn.center = CGPoint(x: self.screenWidth*0.7, y: self.screenHeight*0.8)
            }, completion: { finished in
                // call the animation to pop in Button
                self.okBtn.animation = "wobble"
                self.okBtn.delay = 0
                self.okBtn.duration = 1
                self.okBtn.curve = "swing"
                self.okBtn.animate()
            })
        }
    }
    
    func drawButton(){
        okBtn.frame = CGRect(x: 0, y: 0, width: screenWidth*0.189, height: screenHeight*0.127)
        okBtn.setImage(UIImage(named: "OK_btn.png"), for: .normal)
        self.view.addSubview(okBtn)
        okBtn.addTarget(self, action: #selector(okBtnPressed), for: .touchUpInside)
        okBtn.alpha = 0
    }
    
    @objc func okBtnPressed(sender: UIButton!){
        self.okBtn.animation = "pop"
        self.okBtn.delay = 0
        self.okBtn.duration = 1
        self.okBtn.curve = "swing"
        self.okBtn.animate()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.okBtn.alpha = 0
        }, completion: { finished in
            self.endLessonAndStartTest()
        })
    }
    
    func addLedgerLines(note: String){
        lessonLedgerView.image = UIImage(named: "")
        if note == "E1" || note == "F1" { lessonLedgerView.image = UIImage(named: "ledger_E1.png") }
        if note == "G1" || note == "A1" { lessonLedgerView.image = UIImage(named: "ledger_G1.png") }
        if note == "B1" || note == "C1" { lessonLedgerView.image = UIImage(named: "ledger_B1.png") }
        if note == "A3" { lessonLedgerView.image = UIImage(named: "ledger_G3.png") }
    }
    
    func noteImage(note: String) -> UIImage {
        var img = UIImage()
        if var noteRotation = trebleNotes[note] {
            if noteRotation.rotated {
                img = UIImage(named: "shas_note2")!
            } else {
                img = UIImage(named: "shas_note")!
            }
        }
        if var noteRotation = bassNotes[note] {
            if noteRotation.rotated {
                img = UIImage(named: "shas_note2")!
            } else {
                img = UIImage(named: "shas_note")!
            }
        }
        
        return img
    }
    
    func showRays(){
        ray1.frame = CGRect(x: 0, y: screenHeight, width: (screenWidth*2), height: screenHeight)
        ray1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
        ray1Y = 0 - (screenHeight * 0.3)
        ray2.frame = CGRect(x: 0, y: screenHeight, width: (screenWidth*2), height: screenHeight)
        ray2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
        ray2Y = (screenHeight * 1.3)
        self.view.addSubview(ray1)
        self.view.addSubview(ray2)
    }
    
    func startAnim(target: UILabel, toY: CGFloat, angle: CGFloat){
        UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let radians = CGFloat(Double.pi / 180) * angle
            target.transform = CGAffineTransform(rotationAngle: radians)
            target.center = CGPoint(x: self.screenWidth/2, y: toY)
        }, completion: { finished in
            // call the animation to pop in Button
            
        })
    }
    
    func checkAltPos(note: String) -> Bool{
        var outcome = false
        switch note {
        case "E1", "F1", "G1", "A1", "B1":
            outcome = true
        default:
            outcome = false
        }
        
        return outcome
    }
    
}
