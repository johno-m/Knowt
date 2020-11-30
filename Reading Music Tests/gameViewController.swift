//
//  gameViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 18/10/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

var sS : CGRect!
var sW : CGFloat!
var sH : CGFloat!

var eav : Int! // expansion adjustment view. When you go down to a smaller scale stave for the dual staves then you need to move the stave up.


class gameViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var noteScroll: UIScrollView!
    @IBOutlet weak var goBackBtn: UIButton!
    var noteStave : StaveView!
    var staveLength : CGFloat!
    var barLines = [BarLine]()
    var gapToRemoveAtEnd:CGFloat = 0.0
    var notesOnStave = [Note2]() // note : Note, stave : String
    var lineWidth : CGFloat!
    var rays = [BackgroundRay]()
    var lineCount:CGFloat = 0.0
    var expandedVersion = false
    var dots : [Dot]!
    var gameTurns : [GameTurn]!
    var currentTurn : Int!
    var notesToAdd = [GameNoteToAdd]()
    var numOfRounds = 10
    var endScore : EndScore!
    var runningScore : Int!
    var buttonCircleGuide = ButtonCircleGuide()
    var noteButtons = [NoteButton]() //NoteButtons is the collection of buttons together
    /** UIView placed on top of ScrollView so buttons appear above note, not below */
    var topLayer = UIView()
    var noteButtonBGs = [NoteButtonsBG]()
    var trebleClefStartingPosition = CGFloat()
    var originalPositionSet = false
    @IBOutlet weak var menuBtn: UIButton!
    var menu : InGameMenu!
    var clefBtnsActive = true
    var changingStave = false
    var responseTimer = ResponseTimer()
    var noteStreakStar : NoteStreakStar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sS = UIScreen.main.bounds
        sW = sS.width
        sH = sS.height
        
        showRays()
        setUpGame()
        
        //Set up menu
        menu = InGameMenu(sS: CGSize(width: sW, height: sH))
        view.addSubview(menu)
        
        menu.buttons[0].addTarget(self, action: #selector(goToMenu), for: .touchUpInside)
        menu.buttons[1].addTarget(self, action: #selector(changeStave), for: .touchUpInside)
        menu.buttons[2].addTarget(self, action: #selector(changeStave), for: .touchUpInside)
        menu.buttons[3].addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        
    }
    
    func removeButtons(){
        for entry in noteButtons {
            entry.layer.removeAllAnimations()
            entry.alpha = 0
            entry.removeFromSuperview()
        }
        
        for entry in noteButtonBGs {
            entry.layer.removeAllAnimations()
            entry.alpha = 0
            entry.removeFromSuperview()
        }
        
        noteButtons = [NoteButton]()
        noteButtonBGs = [NoteButtonsBG]()
    }
    
    func setUpGame(){
        currentTurn = 0
        runningScore = 0
        staveLength = 0
        
        if noteStave != nil {
            noteStave.removeFromSuperview()
        }
        
        if usrInf.prefStave != "grand" { lineWidth = round(sH*0.008) } else { lineWidth = round(sH*0.005) }
        
        if expandedVersion {
            lineCount = 10.0
            eav = 0
        } else {
            lineCount = 8.0
            eav = 2
        }

        if freeplayGame.start {
            var noteSelection = [String : String]()
            for note in freeplayGame.notes {
                noteSelection[note] = usrInf.prefStave
            }
            notesToAdd = findNotesForGame(staveType: usrInf.prefStave, numOfRounds: numOfRounds, noteSelection: noteSelection)
        } else {
            notesToAdd = findNotesForGame(staveType: usrInf.prefStave, numOfRounds: numOfRounds, noteSelection: chooseNotes(staveType: usrInf.prefStave))
        }
        
        print("|| notesToAdd == \(notesToAdd)")
        setUpScroll()
        print("USER PREFERENCE: \(usrInf.prefStave)")
        gameTurns = buildTurns(numOfTurns: numOfRounds-1, notesToAdd: notesToAdd)
        startTurn(turn: currentTurn, action: "first")
        UIView.animate(withDuration: 1, delay:0, animations: {
            self.noteStave.alpha = 1
        }, completion: { finished in
//            self.menu.buttons[1].isEnabled = true
//            self.menu.buttons[2].isEnabled = true
            self.changingStave = false
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gameViewController.closeMenu(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        //add the note streak star to the game screen
        noteStreakStar = NoteStreakStar(sS: CGSize(width: sW, height: sH))
        view.addSubview(noteStreakStar)
        updateStar()
    }
    
    @objc public func goToMenu(_ sender: UIButton){
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @objc public func restartGame(_ sender: UIButton){
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @objc public func changeStave(_ sender: UIButton){
        let clef = usrInf.prefStave
        
        if sender.tag == 1 {
            changingStave = true
            noteScroll.layer.removeAllAnimations()
            if clef == "bass" {
                usrInf.prefStave = "grand"
                sender.backgroundColor = UIColor(red:0.00, green:0.58, blue:0.58, alpha:1.0)
                UIView.animate(withDuration: 1, delay:0, animations: {
                    self.noteStave.alpha = 0
                    self.removeButtons()
//                    self.menu.buttons[1].isEnabled = false
//                    self.menu.buttons[2].isEnabled = false
                }, completion: { finished in
                    self.setUpGame()
                })
                
                //                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
                //                self.present(nextViewController, animated: true, completion: nil)
            }
            if clef == "grand" {
                usrInf.prefStave = "bass"
                
                sender.backgroundColor = UIColor(red:0.08, green:0.79, blue:0.72, alpha:1.0)
                UIView.animate(withDuration: 1, delay:0, animations: {
                    self.noteStave.alpha = 0
                    self.removeButtons()
//                    self.menu.buttons[1].isEnabled = false
//                    self.menu.buttons[2].isEnabled = false
                }, completion: { finished in
                    self.setUpGame()
                })
                
                //                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
                //                self.present(nextViewController, animated: true, completion: nil)
            }
        }
        if sender.tag == 2 {
            changingStave = true
            noteScroll.layer.removeAllAnimations()
            if clef == "grand" {
                usrInf.prefStave = "treble"
                
                sender.backgroundColor = UIColor(red:0.08, green:0.79, blue:0.72, alpha:1.0)
                UIView.animate(withDuration: 1, delay:0, animations: {
                    self.noteStave.alpha = 0
                    self.removeButtons()
//                    self.menu.buttons[1].isEnabled = false
//                    self.menu.buttons[2].isEnabled = false
                }, completion: { finished in
                    self.setUpGame()
                })
                
                //                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
                //                self.present(nextViewController, animated: true, completion: nil)
            }
            if clef == "treble" {
                usrInf.prefStave = "grand"
                sender.backgroundColor = UIColor(red:0.00, green:0.58, blue:0.58, alpha:1.0)
                UIView.animate(withDuration: 1, delay:0, animations: {
                    self.noteStave.alpha = 0
                    self.removeButtons()
//                    self.menu.buttons[1].isEnabled = false
//                    self.menu.buttons[2].isEnabled = false
                }, completion: { finished in
                    self.setUpGame()
                })
                //                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
                //                self.present(nextViewController, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    func startTurn(turn: Int, action: String){
        updateStar()
        
        if(turn < numOfRounds){
            scrollStave(to: notesOnStave[turn], turn: turn, action: "scrollAndShowButtons")
        } else {
            endScore = EndScore(numOfRounds: numOfRounds, scoreNum: 0)
            view.addSubview(endScore)
            endScore.show()
            
            showHighlights()
        }
        
    }
    
    func buildTurns(numOfTurns: Int, notesToAdd: [GameNoteToAdd]) -> [GameTurn]{
        var turns = [GameTurn]()
        for i in 0...numOfTurns {
            turns.append(GameTurn(turnNumber: i, note: notesToAdd[i].note, staveType: notesToAdd[i].stave))
        }
        return turns
    }
    
    func addNotesToStave(notesToAdd: [GameNoteToAdd], lineWidth: CGFloat, lineCount: CGFloat){
        
        notesOnStave = [Note2]()
        
        for (i, note) in notesToAdd.enumerated() {
            
            var noteToAdd : noteStruct!
            
            if note.stave == "treble" {
                noteToAdd = trebleNotes[note.note]
            } else {
                noteToAdd = bassNotes[note.note]

            }
            
            notesOnStave.append(Note2(pos: i, stave: note.stave, note: note.note, gapSize: noteStave.gapSize, noteGap: noteStave.noteGap, stavePosition: noteToAdd.stavePosition, lineWidth: noteStave.lineWidth, topLine: noteStave.staveLineArray[0].lineY, stp: noteStave.startingPos))
            noteStave.addSubview(notesOnStave[notesOnStave.count-1])
           
        }
    }
    
    func chooseNotes(staveType: String) -> [String : String] {
        
        var noteSelection = [String : String]()
        var allTrebleNotes = noteLevelList[usrInf.instrument]
        var allBassNotes = noteLevelList[usrInf.instrument]
        if staveType == "treble" {
            for i in 0...usrInf.treblelevel {
                for note in allTrebleNotes![i] {
                    noteSelection[note] = "treble"
                }
            }
        }
        if staveType == "bass" {
            for i in 0...usrInf.basslevel {
                for note in allBassNotes![i] {
                    noteSelection[note] = "bass"
                }
            }
        }
        
        return noteSelection
    }
    
    func findNotesForGame(staveType: String, numOfRounds: Int, noteSelection: [String : String]) -> [GameNoteToAdd] {
        /** Empty array to be filled with 100 notes */
        var selectionList = [GameNoteToAdd]()
        /** Final list of notes */
        var list = [GameNoteToAdd]()
        /** List of the notes to be chosen from */
        var notesInGame = [String : NoteInGame]()
        /** Total score of all the notes added together */
        var totalScore:Float = 0
        
        struct NoteInGame {
            var noteScore : Int
            var notePerc : Float //note perc is how much of the total score this is
            var noteWeight : Float //note weight is how much it needs to be worked on in a measurement from 0 to 100
            var stave: String
        }
        
        /** The trebleNotes or bassNotes variable */
        var noteList:[String : noteStruct]!
        
        if staveType == "treble" {
            noteList = trebleNotes
        } else {
            noteList = bassNotes
        }
        
        for note in noteSelection {
            totalScore += Float(noteList[note.key]!.score)
            print("\(note.key) score = \(noteList[note.key]!.score)")
            notesInGame[note.key] = NoteInGame(noteScore: noteList[note.key]!.score, notePerc: 0, noteWeight: 0, stave: staveType)
        }
        print("Total Score = \(totalScore)")
        
        for note in noteSelection {
            notesInGame[note.key]!.notePerc = round((Float(noteList[note.key]!.score) / totalScore)*100)
            notesInGame[note.key]!.noteWeight = 100 - notesInGame[note.key]!.notePerc
            print("Note \(note.key) notePerc = \(notesInGame[note.key]!.notePerc)")
            print("Note \(note.key) noteWeight = \(notesInGame[note.key]!.noteWeight)")
            if notesInGame[note.key]!.noteWeight > 0 {
                
            } else {
                notesInGame[note.key]!.noteWeight = 100
            }
        }
        
        for note in notesInGame {
            var i = 0
            while i < Int(note.value.noteWeight) {
                selectionList.append(GameNoteToAdd(note: note.key, stave: staveType))
                i += 1
            }
        }
        
        var i = 0
        while i < numOfRounds {
            let randomNumber = Int.random(in: 0 ..< selectionList.count)
            list.append(selectionList[randomNumber])
            i += 1
        }
        print("Chosen Notes = \(list)")
        return list.shuffled()
        
    }
    
    // Find the Width of the Stave. Has to be called early so turned into its own function.
    func findWidthOfStave(numOfNotes: Int, noteWidth: CGFloat, padding: CGFloat) -> CGFloat{
        let output = (CGFloat(numOfNotes) * noteWidth) + padding + sW
        return output
    }
    
    func updateStar(){
        if noteStreakStar != nil {
            noteStreakStar.updateNumber(num: usrInf.noteStreak)
            noteStreakStar.animateFill()
            if usrInf.noteStreak > 3 {
                print("Showing the star")
                noteStreakStar.show()
            } else {
                print("Hiding the star")
                noteStreakStar.hide()
            }
        }
        
        
    }
    
    func showRays(){
        rays = [
            BackgroundRay(bgImage: UIImage(named: "orangeRay")!),
            BackgroundRay(bgImage: UIImage(named: "pinkRay")!),
            BackgroundRay(bgImage: UIImage(named: "tealRay")!)
        ]
        var i = 0
        let rayAngle:[CGFloat] = [-39, -26.25, -15.95]
        let rayDelays = [0.7, 0.8, 1]
        let rayY:[CGFloat] = [0.496, 0.796, 0.986]
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let height = UIApplication.shared.statusBarFrame.size.height
        
        for ray in rays {
            bgView.addSubview(ray)
            UIView.animate(withDuration: 2, delay:rayDelays[i], usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                let radians = CGFloat(Double.pi / 180) * rayAngle[i]
                ray.transform = CGAffineTransform(rotationAngle: radians)
                ray.center = CGPoint(x: screenWidth/2, y: screenHeight * rayY[i])
            }, completion: { finished in
                
            })
            i += 1
        }
    }
    
    func addButtonsToNote(note: Note2, gameTurns: [GameTurn], turnNum: Int) {
        // get the buttons to add
        let buttonList:[String] = gameTurns[currentTurn].buttons
        var degrees = [Double]()
        var delays = [0, 0.2, 0.4]
        let centerPoint = note.center
        let topSafeZone = sH*0.3
        let bottomSafeZone = sH*0.7
        if centerPoint.y < topSafeZone {
            degrees = [10.0, 130.0, 190.0]
        }
        if centerPoint.y > bottomSafeZone {
            degrees = [190.0, 310.0, 10.0]
        }
        if centerPoint.y > topSafeZone && centerPoint.y < bottomSafeZone {
            degrees = [10.0, 120.0, 190.0]
        }
        var i = 0
        
        removeButtons()
        
        for button in buttonList {
            
            let sizeVarient = CGFloat.random(in: 0 ..< 0.6)
            let a:Double = (degrees[i]) * Double.pi / 180
            let r:Double = Double(noteStave.gapSize * 2.8+sizeVarient)
            
            let xpoint = CGFloat(Double(centerPoint.x) + r*cos(a))
            let ypoint = CGFloat(Double(centerPoint.y) + r*sin(a))
            
            let testButton = NoteButton(diameter: noteStave.gapSize * 2+sizeVarient, colour: randomColour(), labelText: button, tag: 0)
            let testButtonBG = NoteButtonsBG(diameter: noteStave.gapSize * 2+sizeVarient)
            
            testButton.center = CGPoint(x: xpoint, y: ypoint)
            testButtonBG.center = CGPoint(x: xpoint, y: ypoint)
            testButton.tag = i
            noteButtons.append(testButton)
            noteButtonBGs.append(testButtonBG)
            noteScroll.addSubview(noteButtonBGs[noteButtons.count-1])
            noteScroll.addSubview(noteButtons[noteButtons.count-1])
            noteButtons[noteButtons.count-1].addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            noteButtons[noteButtons.count-1].show(delay: delays[i])
            noteButtonBGs[noteButtons.count-1].show(delay: delays[i])
            
            i += 1
        }
        
        responseTimer = ResponseTimer()
        
        
    }
    /*
    func moveClefs(){
        if usrInf.prefStave == "grand" {
            let clefX = noteStave.trebleClef
            let relativeX = noteStave.topStave.convert(clefX.center, to: self.view)
            
            if relativeX.x < sW*0.1 {
                UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.noteStave.trebleClef.center.x = clefX.center.x - (relativeX.x - sW*0.08)
                    self.noteStave.bassClef.center.x = clefX.center.x
                }, completion: nil)
                UIView.animate(withDuration: 1, animations: {
                    self.noteStave.timeSig1.alpha = 0
                    self.noteStave.timeSig2.alpha = 0
                    if self.currentTurn > 2 {
                        self.notesOnStave[self.currentTurn-2].alpha = 0
                    }
                    
                }, completion: { finished in
                    // nothing
                })
            }
            
        }
        
    }
    func undoMoveClefs(){
        for note in notesOnStave {
            UIView.animate(withDuration: 1, animations: {
                note.alpha = 1
            }, completion: nil)
        }
        UIView.animate(withDuration: 1, animations: {
            self.noteStave.timeSig1.alpha = 1
            self.noteStave.timeSig2.alpha = 1
            if self.currentTurn > 2 {
                self.notesOnStave[self.currentTurn-2].alpha = 0
            }
            
        }, completion: nil)
    }
    */
    @objc public func closeMenu(_ sender:UITapGestureRecognizer){
        
        if sender.state == .ended {
            
            let touchLocation: CGPoint = sender.location(in: sender.view)
            let containsPoint = menu.bounds.contains(sender.location(in: menu))
            if containsPoint {
                
            } else {
                menu.hide()
            }
        }
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        menu.show()
    }
    
    @objc public func buttonPressed(_ sender:SpringButton!) {
        addResponseTime(note: notesOnStave[currentTurn].note, newTime: responseTimer.count)
        responseTimer.stop()
        if menu.toggled {
            menu.hide()
        }
        
        let sT = gameTurns[currentTurn].stave // Stave Type?
        gameTurns[currentTurn].answered = true
        sender.animation = "pop"
        
        sender.animate()
        
        var delays = [0, 0.3, 0.6]
        if sender.tag == gameTurns[currentTurn].correctTag {
            print("Correct button pressed!")
            notesOnStave[currentTurn].noteImage.tintColor = UIColor.green
            notesOnStave[currentTurn].animation = "pop"
            notesOnStave[currentTurn].animate()
            gameTurns[currentTurn].answeredCorrectly = true
            usrInf.noteStreak += 1
            if(usrInf.noteStreak > 10){ noteStreakStar.shake() } // shake the note if it is going well
            updateScores(correct: true, note: gameTurns[currentTurn].note, stave: sT!)
            addFlair(targetNote: notesOnStave[currentTurn], outcome: "correct", noteStreak: usrInf.noteStreak)
        } else {
            print("Wrong button pressed!")
            notesOnStave[currentTurn].noteImage.tintColor = UIColor.red
            notesOnStave[currentTurn].animation = "wobble"
            notesOnStave[currentTurn].animate()
            gameTurns[currentTurn].answeredCorrectly = false
            usrInf.noteStreak = 0
            updateScores(correct: false, note: gameTurns[currentTurn].note, stave: sT!)
            addFlair(targetNote: notesOnStave[currentTurn], outcome: "incorrect", noteStreak: usrInf.noteStreak)
        }
        var i = 0
        for button in noteButtons {
            button.hide(delay: delays[i])
            
            i += 1
        }
        i = 0
        for buttonBG in noteButtonBGs {
            buttonBG.hide(delay: delays[i])
            i += 1
        }
        
        currentTurn += 1
        startTurn(turn: currentTurn, action: "first")
    }
    
    func addFlair(targetNote: Note2, outcome: String, noteStreak: Int){
        let newFlair = NoteFlair(note: targetNote, outcome: outcome, noteStreak: usrInf.noteStreak)
        var bassClefStave:UIView = noteStave
        if targetNote.stave == "treble" {
            noteStave.addSubview(newFlair)
        } else {
            bassClefStave.addSubview(newFlair)
        }
        newFlair.startAnimation()
    }
    
    func updateScores(correct: Bool, note: String, stave: String){
        if stave == "treble" {
            let cRC:Int = (trebleNotes[note]!.correctRunningCount)
            let iRC:Int = (trebleNotes[note]!.incorrectRunningCount)
            var scoreAddition = 5
            if correct {
                if cRC >= 3 { scoreAddition = 8 }
                if cRC >= 5 { scoreAddition = 10 }
                if cRC >= 6 { scoreAddition = 20 }
                trebleNotes[note]!.correctRunningCount += 1
                trebleNotes[note]!.incorrectRunningCount = 0
                trebleNotes[note]!.correctCount += 1
            } else {
                if iRC >= 3 { scoreAddition = -8 }
                if iRC >= 5 { scoreAddition = -10 }
                if iRC >= 6 { scoreAddition = -20 }
                trebleNotes[note]!.correctRunningCount = 0
                trebleNotes[note]!.incorrectRunningCount += 1
                trebleNotes[note]!.incorrectCount += 1
            }
            
            trebleNotes[note]!.score += scoreAddition
            
        } else {
            let cRC:Int = (bassNotes[note]!.correctRunningCount)
            let iRC:Int = (bassNotes[note]!.incorrectRunningCount)
            var scoreAddition = 5
            if correct {
                if cRC >= 3 { scoreAddition = 8 }
                if cRC >= 5 { scoreAddition = 10 }
                if cRC >= 6 { scoreAddition = 20 }
                bassNotes[note]!.correctCount += 1
                bassNotes[note]!.correctRunningCount += 1
                bassNotes[note]!.incorrectRunningCount = 0
            } else {
                if iRC >= 3 { scoreAddition = -8 }
                if iRC >= 5 { scoreAddition = -10 }
                if iRC >= 6 { scoreAddition = -20 }
                bassNotes[note]!.incorrectCount += 1
                bassNotes[note]!.correctRunningCount = 0
                bassNotes[note]!.incorrectRunningCount += 1
            }
            
            bassNotes[note]!.score += scoreAddition
            
        }
        saveUserInf()
        
    }
    
    func scrollStave(to: Note2, turn: Int, action: String){
        let absoluteX = to.center
        
        if action == "scrollAndShowButtons" {
            if currentTurn == 0 {
                UIView.animate(withDuration: 1.5, delay:0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.noteScroll.contentOffset.x = absoluteX.x - (sW/2)
                }, completion: { finished in
                    if !self.changingStave { self.addButtonsToNote(note: self.notesOnStave[turn], gameTurns: self.gameTurns, turnNum: turn) }
                    
                })
            }
            if currentTurn > 0 && currentTurn <= numOfRounds {
                UIView.animate(withDuration: 0.5, delay:0, animations: {
                    self.noteScroll.contentOffset.x = absoluteX.x - (sW/2)
                }, completion: { finished in
                    if !self.changingStave { self.addButtonsToNote(note: self.notesOnStave[turn], gameTurns: self.gameTurns, turnNum: turn) }
                    
                })
            }
            if currentTurn > numOfRounds {
                UIView.animate(withDuration: 0.5, delay:0, animations: {
                    self.noteScroll.contentOffset.x = absoluteX.x - (sW/2)
                }, completion: nil)
            }
        }
        if action == "scroll" {
            UIView.animate(withDuration: 0.8, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.noteScroll.contentOffset.x = absoluteX.x - (sW/2)
            }, completion: { finished in
                
            })
        }
    }
    
    func setUpScroll(){
        //draw the staves. Update later.
        
        // (staveType: usrInf.prefStave, staveLength: staveLength, lineWidth: lineWidth, lineCount: lineCount, sS: sS)
        noteStave = StaveView(spaceToFill: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 20), staveType: usrInf.prefStave, noteCount: numOfRounds, spacing: "wide", showClef: true, timeSig: true)
        noteScroll.addSubview(noteStave)
        addNotesToStave(notesToAdd: notesToAdd, lineWidth: lineWidth, lineCount: lineCount)
        
        noteScroll.contentSize.width = noteStave.frame.width
        noteScroll.isScrollEnabled = false
        
        topLayer.frame = CGRect(x: 0, y: 0, width: staveLength * 1.01, height: noteStave.frame.height)
        topLayer.layer.zPosition = 50
        noteScroll.addSubview(topLayer)
    }
    
    func showHighlights(){
        noteStreakStar.hide()
        var highlightReel = [Highlight]()
        for note in notesOnStave.reversed() {
            
            highlightReel.append(Highlight(pos: note.pos, note: note, turn: gameTurns[note.pos]))
            
        }
        highlightStep(highlightReel: highlightReel, step: 0)
    }
    
    func highlightStep(highlightReel: [Highlight], step: Int){
        print("Step: \(step), num of rounds: \(numOfRounds)")
        
        if step < numOfRounds {
            let targetNote = highlightReel[step].note
            let nextStep = step + 1
            scrollStave(to: targetNote, turn: currentTurn, action: "scroll")
            let target = highlightReel[step].note
            addCorrectAnswer(target: target, highlight: highlightReel[step])
            jumpOffStave(target: target)
            
            if highlightReel[step].turn.answeredCorrectly == true {
                runningScore += 1
                endScore.score.text = "\(runningScore!)"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                self.highlightStep(highlightReel: highlightReel, step: nextStep)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                self.checkPromotion()
            }
            
        }
        
    }
    
    func checkPromotion(){
//        usrInf.treblelevel
//        usrInf.instrument\]
        
        var doPromotion = true
        
        var unlockedNotes = listOfUnlockedNotes(stave: usrInf.prefStave)
        
        print(" ")
        print("--- CHECKING PROMOTION ---")
        print(" ")
        for note in unlockedNotes {
            print("\(note) score is \((trebleNotes[note]?.score)!)")
            if (trebleNotes[note]?.score)! < promotionThreshold {
                doPromotion = false
            }
        }
        print(" ")
        print("--- CHECKING PROMOTION ---")
        print(" ")
        if doPromotion {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notePromoteViewController") as! notePromoteViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        } else {
            self.outroSequence()
        }
    }
    
    func addCorrectAnswer(target: Note2, highlight: Highlight){
        var humanName = "A"
        if target.stave == "treble" {
            humanName = (trebleNotes[target.note]?.humanNoteName)!
        }
        if target.stave == "bass" {
            humanName = (bassNotes[target.note]?.humanNoteName)!
        }
        
        let centerPoint = target.center
        
        let noteLabel = UILabel()
        noteLabel.text = "\(humanName)"
        noteLabel.textColor = UIColor.white
        noteLabel.font = UIFont(name: "Futura-Bold", size: noteStave.gapSize)
        
        noteLabel.frame = CGRect(x: 0, y: 0, width: noteStave.gapSize, height: noteStave.gapSize)
        noteLabel.center = centerPoint
        noteLabel.alpha = 0
        noteScroll.addSubview(noteLabel)
        UIView.animate(withDuration: 1, delay:0, animations: {
            noteLabel.alpha = 1
        }, completion: nil)
    }
    
    func jumpOffStave(target: Note2){
        
        let path = UIBezierPath()
        let startPoint = target.center
        let sP_X = Int(startPoint.x)
        let sP_Y = Int(startPoint.y)
        path.move(to: startPoint)
        
        path.addCurve(to: CGPoint(x: sP_X+50, y: sP_Y+1000), controlPoint1: CGPoint(x: sP_X+25, y: sP_Y-70), controlPoint2: CGPoint(x: sP_X+45, y: sP_Y+100))
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        
        // set some more parameters for the animation
        // this rotation mode means that our object will rotate so that it's parallel to whatever point it is currently on the curve
        anim.rotationMode = kCAAnimationDiscrete
        anim.repeatCount = 0
        anim.duration = 1.0
        
        // we add the animation to the squares 'layer' property
        target.layer.add(anim, forKey: "animate position along path")
        
        UIView.animate(withDuration: 1, delay:0, animations: {
            target.alpha = 0
            target.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180)*50)
        }, completion: { finished in
            
        })
    }
    
    func outroSequence(){
        let image = UIImage(named: "star")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        let star = UIImageView(image: image)
        
        star.frame = CGRect(x: 0, y: 0, width: sH*0.3, height: sH*0.3)
        star.center = CGPoint(x: sW*0.5, y: sH*0.5)
        star.tintColor = UIColor.white
        
        let fill = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        fill.backgroundColor = UIColor(red:0.98, green:0.45, blue:0.15, alpha:1.0)
        fill.center = CGPoint(x: sW*0.5, y: sH*0.5)
        fill.layer.cornerRadius = fill.frame.width * 0.5
        view.addSubview(fill)
        view.addSubview(star)
        UIView.animate(withDuration: 0.7, delay:0, options: .allowUserInteraction, animations: {
            fill.transform = CGAffineTransform(scaleX: 70, y: 70)
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, delay:0, options: .allowUserInteraction, animations: {
                star.alpha = 0
            }, completion: { finished in
                
            })
        })
        
        let button1 = UIButton()
        button1.setImage(UIImage(named: "btn-playagain"), for: .normal)
        button1.frame = CGRect(x: sW*0.1, y: 0, width: sW*0.8, height: sW*0.1)
        button1.setTitle(" PLAY AGAIN", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        button1.titleLabel?.font = UIFont(name: "Futura-Bold", size: 80)
        button1.titleLabel?.adjustsFontSizeToFitWidth = true
        button1.alpha = 0
        view.addSubview(button1)
        
        let button2 = UIButton()
        button2.setImage(UIImage(named: "btn-mainmenu"), for: .normal)
        button2.frame = CGRect(x: sW*0.1, y: 0, width: sW*0.8, height: sW*0.1)
        button2.setTitle(" MAIN MENU", for: .normal)
        button2.setTitleColor(UIColor.white, for: .normal)
        button2.titleLabel?.font = UIFont(name: "Futura-Bold", size: 80)
        button2.titleLabel?.adjustsFontSizeToFitWidth = true
        button2.alpha = 0
        view.addSubview(button2)
        
        let button3 = UIButton()
        button3.setImage(UIImage(named: "btn-viewprogress"), for: .normal)
        button3.frame = CGRect(x: sW*0.1, y: 0, width: sW*0.8, height: sW*0.1)
        button3.setTitle(" VIEW PROGRESS", for: .normal)
        button3.setTitleColor(UIColor.white, for: .normal)
        button3.titleLabel?.font = UIFont(name: "Futura-Bold", size: 80)
        button3.titleLabel?.adjustsFontSizeToFitWidth = true
        button3.alpha = 0
        view.addSubview(button3)
        
        button2.center.y = sH/2
        button1.center.y = sH/2-sW*0.1
        button3.center.y = sH/2+sW*0.1
        button1.contentHorizontalAlignment = .left
        button2.contentHorizontalAlignment = .left
        button3.contentHorizontalAlignment = .left
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        button1.addTarget(self, action: #selector(endButtonPressed), for: .touchUpInside)
        button2.addTarget(self, action: #selector(endButtonPressed), for: .touchUpInside)
        button3.addTarget(self, action: #selector(endButtonPressed), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.7, delay:1, options: .allowUserInteraction, animations: {
            print("done")
            button1.alpha = 1
            button2.alpha = 1
            button3.alpha = 1
        }, completion: { finished in
            
        })
        
    }
    
    func randomColour() -> UIColor {
        let rand1 = CGFloat.random(in: 0 ..< 1)
        let rand2 = CGFloat.random(in: 0 ..< 1)
        let rand3 = CGFloat.random(in: 0 ..< 1)
        let colour = UIColor(red: rand1, green: rand2, blue: rand3, alpha: 1)
        return colour
    }
    
    
    @objc public func endButtonPressed(_ sender:UIButton!) {
        if sender.tag == 0 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        if sender.tag == 1 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        if sender.tag == 2 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "noteProgressViewController") as! noteProgressViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    struct Highlight {
        var pos : Int
        var note : Note2
        var turn : GameTurn
    }
    
    struct GameNote {
        var note : Note2
        var stave : String
    }
    struct GameNoteToAdd {
        var note : String
        var stave : String
    }
    
}


class BackgroundRay : UIImageView {
    var bgImage : UIImage!
    init(bgImage: UIImage){
        var rayHeight = ((sW*1.4) / 1450) * 400
        super.init(frame: CGRect(x: 0-sW*0.2, y: sH, width: sW*1.4, height: rayHeight))
        image = bgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class GameTurn {
    
    var turnNumber : Int!
    var answeredCorrectly : Bool!
    var answered : Bool!
    var note : String!
    var buttons : [String]!
    var correctTag : Int!
    var stave : String!
    
    init(turnNumber: Int, note: String, staveType: String){
        self.turnNumber = turnNumber
        self.answeredCorrectly = false
        self.answered = false
        self.note = note
        self.stave = staveType
        var noteArray = trebleNotes
        if(staveType == "bass"){
            noteArray = bassNotes
        }
        
        self.buttons = assignButtons(note: note, noteArray: noteArray)
    }
    
    func assignButtons(note: String, noteArray: [String : noteStruct]) -> [String] {
        let humanName:String = "\(noteArray[note]?.humanNoteName ?? "")"
        var buttons = [humanName]
        var options = ["A","B","C","D","E","F","G"]
        options = options.filter { $0 != humanName } // array has had the correct answer removed to avoid duplicates
        for i in 0...1 {
            let rand:Int = Int(arc4random_uniform(UInt32(options.count)))
            buttons.append(options[rand])
            options.remove(at: rand)
        }
        buttons = buttons.shuffled()
        
        self.correctTag = buttons.index(of: humanName)
        
        return buttons
    }
    
    
    
}

class NoteButton : SpringButton {
    
    var colour : UIColor!
    
    init(diameter: CGFloat, colour: UIColor, labelText: String, tag: Int){
        
        super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        self.colour = colour
        layer.cornerRadius = diameter*0.5
        backgroundColor = colour
        
        setTitle(labelText, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont(name: "Futura-Bold", size: 60)
        titleLabel?.adjustsFontSizeToFitWidth = true
        self.tag = tag
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = colour
    }
    
    func show(delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { // change 2 to desired number of seconds
            self.alpha = 1
            self.duration = 1.5
            self.animation = "pop"
            self.animate()
        }
    }
    func hide(delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { // change 2 to desired number of seconds
            self.alpha = 1
            self.duration = 1.5
            self.animation = "fadeOut"
            self.animate()
        }
    }
    func pop(){
        self.animation = "pop"
        self.duration = 2
        self.animate()
    }
}

class NoteButtonsBG : SpringView {
    
    init(diameter: CGFloat){
        let d = diameter * 1.2
        super.init(frame: CGRect(x: 0, y: 0, width: d, height: d))
        layer.cornerRadius = d*0.5
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func show(delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.alpha = 1
            self.duration = 2
            self.animation = "fadeIn"
            self.animate()
        }
    }
    func hide(delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.duration = 1
            self.animation = "fadeOut"
            self.animate()
        }
    }
    func pop(){
        self.animation = "pop"
        self.animate()
    }
}

class ButtonHolders : UIView {
    init(noteScale: CGFloat, name: String){
        super.init(frame: CGRect(x: 0, y: 0, width: noteScale * 12, height: noteScale * 12))
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
    
}

class ButtonCircleGuide : UIView {
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        layer.cornerRadius = frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        layer.cornerRadius = frame.size.width / 2
    }
}

class EndScore : SpringView {
    let outOfLabel = UILabel()
    let score = UILabel()
    let upperValue = UILabel()
    
    init(numOfRounds: Int, scoreNum: Int){
        
        super.init(frame: CGRect(x: sW-(sH*0.35), y: sH*0.85, width: sH*0.35, height: sH*0.15))
        let lW = frame.width
        let lH = frame.height
        outOfLabel.text = "out\nof"
        outOfLabel.numberOfLines = 0
        score.text = "\(scoreNum)"
        upperValue.text = "\(numOfRounds)"
        outOfLabel.frame = CGRect(x: lW*0.35, y: 0, width: lW*0.3, height: lH)
        score.frame = CGRect(x: 0, y: 0, width: lW*0.35, height: lH)
        upperValue.frame = CGRect(x: lW*0.65, y: 0, width: lW*0.35, height: lH)
        score.textAlignment = .right
        outOfLabel.textAlignment = .center
        self.addSubview(outOfLabel)
        self.addSubview(score)
        self.addSubview(upperValue)
        outOfLabel.font = UIFont(name: "Futura-Bold", size: 20)
        outOfLabel.adjustsFontSizeToFitWidth = true
        score.font = UIFont(name: "Futura-Bold", size: 90)
        score.adjustsFontSizeToFitWidth = true
        upperValue.font = UIFont(name: "Futura-Bold", size: 90)
        upperValue.adjustsFontSizeToFitWidth = true
        outOfLabel.textColor = UIColor.white
        score.textColor = UIColor.white
        upperValue.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show(){
        self.animation = "slideUp"
        self.curve = "easeInOut"
        self.duration = 1.5
        self.animate()
    }
    func hide(){
        self.animation = "zoomOut"
        self.curve = "easeInOut"
        self.duration = 1.5
        self.animate()
    }
    
}

