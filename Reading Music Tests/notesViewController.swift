//
//  notesViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 25/07/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class notesViewController: UIViewController {
    /*
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var freeplayBG: UIImageView!
    
    @IBOutlet weak var noteStreakImage: UIImageView!
    @IBOutlet weak var noteStreakLabel: UILabel!
    @IBOutlet weak var nameNoteBG: UILabel!
    @IBOutlet weak var note1: UIImageView!
    @IBOutlet weak var note2: UIImageView!
    @IBOutlet weak var note3: UIImageView!
    @IBOutlet weak var note4: UIImageView!
    @IBOutlet weak var note5: UIImageView!
    @IBOutlet weak var note6: UIImageView!
    @IBOutlet weak var note7: UIImageView!
    @IBOutlet weak var note8: UIImageView!
    @IBOutlet weak var staveView: UIImageView!
    @IBOutlet weak var gameTitle: UIImageView!
    @IBOutlet weak var maskView: UIImageView!
    @IBOutlet weak var circleView: UIImageView!
    @IBOutlet weak var buttonLabel1: UILabel!
    @IBOutlet weak var buttonLabel2: UILabel!
    @IBOutlet weak var buttonLabel3: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var progBG: UIImageView!
    
    @IBOutlet weak var bottomButtonsLight: UIImageView!
    @IBOutlet weak var bottomButtonLeft: UIImageView!
    @IBOutlet weak var bottomButtonMiddle: UIImageView!
    @IBOutlet weak var bottomButtonRight: UIImageView!
    
    @IBOutlet weak var ray1: UIImageView!
    @IBOutlet weak var ray2: UIImageView!
    @IBOutlet weak var ray3: UIImageView!
    @IBOutlet weak var progBarBG: UIImageView!
    
    let endView = UIView()
    let endView_message = UILabel()
    let endView_button1 = UIButton()
    let endView_button2 = UIButton()
    let endView_button3 = UIButton()
    
    var ray1_y = CGFloat()
    var ray2_y = CGFloat()
    var ray3_y = CGFloat()
    
    var staveHeight = CGFloat()
    var scrollWidth = CGFloat()
    var staveWidth = CGFloat()
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    var debugTimer: Timer!
    var circleTimer: Timer!
    var textTimer: Timer!
    var gameRecord = [Int]()
    var gameIncorrectRecord = [["Correct", "Guessed"]]
    var roundCount = 0
    var roundScore = 0
    
    var notePool = [String]()
    
    let notePositions = [0.15, 0.266, 0.379, 0.492, 0.609, 0.719, 0.829, 0.939]
    var notesInGame = [String]()
    var noteSelection = [String]()
    var noteHolders = [UIImageView]()
    var buttonHolders = [UIButton]()
    var correctButton = 0
    var buttonList = [String]()
    var note_width:CGFloat = 0
    var highlightCount = 7
    var buttonActive:Bool = false

    let colors = [UIColor(red: 0.8824, green: 0.5176, blue: 0, alpha: 1), UIColor(red: 0.5843, green: 0.0667, blue: 0.3294, alpha: 1), UIColor(red: 0.0627, green: 0.4902, blue: 0.4471, alpha: 1)]
    
    func checkScroll(){
        print(maskView.frame.height)
    }
    
    @IBAction func answerChosen(_ sender: UIButton) {
        if(buttonActive == true){
            fadeButtons(toggle: "off", picked: sender.tag)
            let note = notesInGame[roundCount-1]
            print("Note in game: \(note)")
            if correctButton == sender.tag {
                if freeplayGame.start != true {
                    allNotes[note] = allNotes[note]! + 10
                    shakeNote(target: noteHolders[roundCount-1], colour: UIColor.green)
                    allNoteStreak += 1
                    notesCorrectCount[note] = notesCorrectCount[note]! + 1
                    noteStreak[note] = noteStreak[note]! + 1
                    gameRecord.append(1)
                    fadeInNoteStreak()
                } else {
                    shakeNote(target: noteHolders[roundCount-1], colour: UIColor.green)
                    gameRecord.append(1)
                }
                
            } else {
                if freeplayGame.start != true {
                    shakeNote(target: noteHolders[roundCount-1], colour: UIColor.red)
                    allNoteStreak = 0
                    allNotes[note] = allNotes[note]! - 10
                    if allNotes[note]! < 0 {
                        allNotes[note] = 0
                    }
                    noteStreak[note] = 0
                    gameRecord.append(0)
                } else {
                    shakeNote(target: noteHolders[roundCount-1], colour: UIColor.red)
                    gameRecord.append(0)
                }
            }
            saveUserInf()
        }
        
    }
    
    
    func shakeNote(target: UIImageView, colour: UIColor){
        let radians = CGFloat(Double.pi / 50)
        let radians2 = CGFloat(-0.1)
        UIView.animate(withDuration: 0.1, delay:0, animations: {
            target.tintColor = colour
            target.transform = CGAffineTransform(rotationAngle: radians)
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, delay:0, animations: {
                target.transform = CGAffineTransform(rotationAngle: radians2)
            }, completion: { finished in
                UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                    target.transform = CGAffineTransform(rotationAngle: 0)
                }, completion: { finished in
                    let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.initRound()
                    }
                })
            })
        })
    }
    
    func bounceNote(target: UIImageView, colour: UIColor){
        let startPos = target.frame.origin.y
        UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseOut, animations: {
            target.tintColor = colour
            target.frame.origin.y = startPos-20
        }, completion: { finished in
            UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseIn, animations: {
                target.frame.origin.y = startPos
            }, completion: { finished in
                UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseOut, animations: {
                    target.frame.origin.y = startPos-10
                }, completion: { finished in
                    UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseIn, animations: {
                        target.frame.origin.y = startPos
                        target.tintColor = colour
                    }, completion: { finished in
                        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            self.initRound()
                        }
                    })
                })
            })
        })
    }
    */
    override func viewDidLoad() {
        //debugTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkScroll), userInfo: nil, repeats: true)
        /*
        let currentUserNotes = noteLevelList[instrument]
        let numberOfLevels = (currentUserNotes?.count)! - 1
        print("number of Levels: \(numberOfLevels)")
        if(userLevel[0] > numberOfLevels) {
            if userLevel[0] > numberOfLevels {
                userLevel[0] = numberOfLevels
            }
        } else {
            
        }
        
        findNotesInGame()
        
        noteHolders = [note1, note2, note3, note4, note5, note6, note7, note8]
        buttonHolders = [button1, button1, button2, button3]
 */
        super.viewDidLoad()
        /*
        let screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
 */
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func viewDidAppear(_ animated: Bool) {
        showTitle()
        entranceSeq()
        loadStave()
        initProgBar()
        
        // show freeplayBG
        if freeplayGame.start == true {
            freeplayBG.alpha = 0
            UIView.animate(withDuration: 2, delay: 2, animations: {
                self.freeplayBG.alpha = 1
            }, completion: nil)
        }
    }
    
    // This function populates the stave using the preset positions in notePositions(array) and the notesInGame(array)
    func addNoteToStave(noteToAdd: String, count: Int, targetNote: UIImageView){
        let imgSrc = "note\(noteToAdd).png"
        let imageSrc = UIImage(named: imgSrc);
        let tintedImage = imageSrc?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        targetNote.image = tintedImage
        let xPos = (staveWidth * CGFloat(notePositions[count])) + screenWidth
        let noteWidth = staveHeight * (284/1414)
        note_width = noteWidth
        targetNote.frame = CGRect(x: xPos, y: 0, width: noteWidth, height: staveHeight)
        targetNote.contentMode = .scaleAspectFit
    }
    
    // This function loads the notes the user knows/has unlocked and then populates an array of 100 spaces using the scores as a negative.
    func findNotesInGame(){
        var i = 0
        //adding functionality for Freeplay. Check to see if freeplay is init and what notes are chosen
        if freeplayGame.start == true {
            noteSelection = freeplayGame.notes
        } else {
            freeplayBG.alpha = 0
            if userLevel[0] == 0 {
                var noteList = noteLevelList[instrument]
                noteSelection = noteList![0]
                print("userLevel is Zero so to avoid a bug the level is defined definitively")
            } else {
                while i <= userLevel[0]{
                    var noteList = noteLevelList[instrument]
                    noteSelection += noteList![i]
                    i+=1
                    print("userLevel not zero. Note Selection = \(noteSelection)")
                }
            }
        }
        
        
        var noteTotal = 0
        var oppositeTotal = 0
        for note in noteSelection {
            noteTotal += allNotes[note]!
        }
        for note in noteSelection {
            var oppositeScore = (noteTotal - allNotes[note]!)
            if oppositeScore == 0 {
                oppositeScore = 100
            }
            oppositeTotal += oppositeScore
        }
        for note in noteSelection {
            var noteOppositeTotal = (noteTotal - allNotes[note]!)
            if noteOppositeTotal == 0 {
                noteOppositeTotal = 100
            }
            let prev = round((Float(noteOppositeTotal) / Float(oppositeTotal)) * 100)
            print("Note: \(note) score is \(prev)")
            var i = 0
            while i < Int(prev) {
                notePool += [note]
                i+=1
            }
        }
        i = 0
        while i < 8 {
            let rand = Int(arc4random_uniform(99))
            notesInGame += [notePool[rand]]
            i+=1
        }
        print(notesInGame)
    }
    let lowNotes = ["E1", "F1", "G1", "A1", "B1"]
    
    func scrollStave(to: CGFloat, note: String){
        var yOffset:CGFloat = 0
        for lowNote in lowNotes {
            if note == lowNote {
                yOffset = 0 - (self.scrollView.frame.height - self.staveView.frame.height)
            }
        }
        UIView.animate(withDuration: 1.5, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.scrollView.contentOffset.x = to
            self.scrollView.contentOffset.y = yOffset
            self.fadeButtons(toggle: "on", picked: 0)
        }, completion: nil)
    }
    
    func showTitle(){
        gameTitle.translatesAutoresizingMaskIntoConstraints = true
        maskView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        maskView.contentMode = .scaleAspectFit // OR .scaleAspectFill
        maskView.clipsToBounds = true
        gameTitle.mask = maskView;
        gameTitle.frame.size.width = 0
        UIView.animate(withDuration: 3, delay: 2, animations: {
            self.gameTitle.frame.size.width = self.screenWidth
        }, completion: nil)
        UIView.animate(withDuration: 3, delay: 5, animations: {
            self.gameTitle.backgroundColor = UIColor(red: 0.196, green: 0.258, blue: 0.235, alpha: 0.1)
        }, completion: nil)
        
    }
    
    func loadStave(){
        //function to load the stave, fill the images for the notes and place them in the correct places.
        
        staveHeight = screenHeight*0.8
        staveWidth = staveHeight*(7806/1414)
        scrollWidth = (staveHeight*(7806/1414))+(screenWidth*2) //these are the dimensions of the stave image and need to be changed if the image is altered
 
        staveView.image = UIImage(named: "noteStave")
        staveView.frame = CGRect(x: 0, y: 0, width: scrollWidth, height: staveHeight)
        staveView.contentMode = .scaleAspectFit
        scrollView.contentSize = CGSize(width: scrollWidth, height: staveHeight)
        scrollView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        var i = 0
        for note in notesInGame {
            addNoteToStave(noteToAdd: note, count: i, targetNote: noteHolders[i])
            i += 1
        }
//        view.addSubview(scrollView)
    }
    
    func initRound(){
        roundCount+=1
        print("Round \(roundCount) starting")
        if roundCount >  8 {
            print("Round limit reached")
            endGame(function: "Highlights")
        } else {
            print("Round limit not yet reached. Starting round")
            killButtons(clickable: true)
            let num = roundCount-1
            let frame = noteHolders[0].superview?.convert(noteHolders[num].frame, to: nil)
            let centerPoint = (screenWidth/2) - (noteHolders[num].frame.width / 2)
            let distToCenter = ((frame?.origin.x)! - centerPoint) + self.scrollView.contentOffset.x
            scrollStave(to: distToCenter, note: notesInGame[num])
            print("Correct Answer this round: \(notesInGame[num])")
            fillButtons(correctAnswer: notesInGame[num])
            updateProgBar()
            if freeplayGame.start != true {
                updateNoteStreak()
            }
            
        }
    }
    
    func fillButtons(correctAnswer: String){
        var allLetters = ["A", "B", "C", "D", "E", "F", "G"]
        var unRandomisedList:[String] = [noteNames[correctAnswer]!]
        var randomisedList:[String] = []
        allLetters = allLetters.filter{$0 != noteNames[correctAnswer]}
        var i = 0
        while i < 2 {
            let rand = Int(arc4random_uniform(UInt32(allLetters.count)))
            unRandomisedList.append(allLetters[rand])
            allLetters = allLetters.filter{$0 != allLetters[rand]}
            i+=1
        }
        i = 0
        while i < 3 {
            let rand = Int(arc4random_uniform(UInt32(unRandomisedList.count)))
            randomisedList.append(unRandomisedList[rand])
            unRandomisedList = unRandomisedList.filter{$0 != unRandomisedList[rand]}
            i+=1
        }
        if randomisedList[0] == "F" && randomisedList[1] == "A" && randomisedList[2] == "G" {
            randomisedList = ["G", "F", "A"]
        }
        correctButton = randomisedList.index(of: noteNames[correctAnswer]!)! + 1
        print("unRandomisedList = \(unRandomisedList) and allLetters = \(allLetters) randomisedList = \(randomisedList) correctButton = \(correctButton)")
        buttonLabel1.text = randomisedList[0]
        buttonLabel2.text = randomisedList[1]
        buttonLabel3.text = randomisedList[2]
        buttonList = randomisedList
    }
    
    func endGame(function: String){
        if freeplayGame.start == true {
            showEndPopUp()
        } else {
            if function == "Highlights" {
                print("End game function called")
                highlightCount = 7
                fadeOutNoteStreak()
                hideButtons()
                showHighlights()
                showFinalScore()
            }
            if function == "EndGamePrompt" {
                
                notesInGameTop3 = [String]()
                var notesInGameRepetition: [String:Int] = [
                    "E1" : 0,
                    "F1" : 0,
                    "G1" : 0,
                    "A1" : 0,
                    "B1" : 0,
                    "C1" : 0,
                    "D1" : 0,
                    "E2" : 0,
                    "F2" : 0,
                    "G2" : 0,
                    "A2" : 0,
                    "B2" : 0,
                    "C2" : 0,
                    "D2" : 0,
                    "E3" : 0,
                    "F3" : 0,
                    "G3" : 0,
                    "A3" : 0
                ]
                
                for notes in notesInGame {
                    notesInGameRepetition[notes]! += 1
                    
                }
                print("Notes in game: \(notesInGame)")
                print("notesInGameRepetition: \(notesInGameRepetition)")
                
                let notesInGameRepetitionDesc = notesInGameRepetition.sorted(by: { $0.value > $1.value })
                notesInGameTop3 = [String]()
                for item in notesInGameRepetitionDesc {
                    notesInGameTop3.append(item.key)
                }
                print("Top 3 are... : \(notesInGameTop3)")
                
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "noteProgressViewController") as! noteProgressViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func endButtonClicked(sender: UIButton!) {
        let btn: UIButton = sender
        if btn.tag == 1 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesViewController") as! notesViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        if btn.tag == 2 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        if btn.tag == 3 {
//            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.present(nextViewController, animated: true, completion: nil)
        }
    }

    var circleCount = 0;
    func drawCircle(){
        circleCount = 0
        circleTimer = Timer.scheduledTimer(timeInterval: 0.0416, target: self, selector: #selector(drawCircleAnim), userInfo: nil, repeats: true)
    }
    
    @objc func drawCircleAnim(){
        if circleCount < 41 {
            self.circleView.alpha = 1
            self.circleView.image = UIImage(named: "circle\(circleCount).png")
            circleCount += 1
            print("circle\(circleCount).png")
        } else {
            circleTimer.invalidate()
            UIView.animate(withDuration: 0.8, delay:0 , animations: {
                self.circleView.alpha = 0
            }, completion: { finished in
                
            })
        }
    }
    
    func entranceSeq(){
        print("Entrance Seq Called")
        ray1_y = ray1.frame.origin.y
        ray2_y = ray2.frame.origin.y
        ray3_y = ray3.frame.origin.y
        ray1.frame.origin.y = screenHeight
        ray2.frame.origin.y = screenHeight
        ray3.frame.origin.y = screenHeight
        ray1.isHidden = false
        ray2.isHidden = false
        ray3.isHidden = false
        noteStreakLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180) * 9.2)
        let noteStreakImage_y = noteStreakImage.frame.origin.y
        noteStreakLabel.alpha = 0
        
        UIView.animate(withDuration: 2, delay:0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.ray3.frame.origin.y = self.ray3_y
        }, completion: { finished in
            
        })
        UIView.animate(withDuration: 2, delay:0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.ray2.frame.origin.y = self.ray2_y
        }, completion: { finished in
            
        })
        UIView.animate(withDuration: 2, delay:0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.ray1.frame.origin.y = self.ray1_y
        }, completion: { finished in
            self.showTitle()
            self.bottomButtonsLight.isHidden = false
            self.bottomButtonLeft.isHidden = false
            self.bottomButtonMiddle.isHidden = false
            self.bottomButtonRight.isHidden = false
            let buttonY = self.bottomButtonsLight.frame.origin.y
            self.bottomButtonsLight.frame.origin.y = self.screenHeight
            self.bottomButtonLeft.frame.origin.y = self.screenHeight
            self.bottomButtonMiddle.frame.origin.y = self.screenHeight
            self.bottomButtonRight.frame.origin.y = self.screenHeight
            UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.bottomButtonsLight.frame.origin.y = buttonY
                self.bottomButtonLeft.frame.origin.y = buttonY
                self.bottomButtonMiddle.frame.origin.y = buttonY
                self.bottomButtonRight.frame.origin.y = buttonY
            }, completion: { finished in
                self.initRound()
            })
            self.showTitle()
        })
        if(allNoteStreak > 0){
            fadeInNoteStreak()
        }
    }
    
    let progMask = UIImageView()
    let progLabel = UILabel()
    var barHeight = 0
    var barWidth = 0
    
    func initProgBar(){
        barHeight = Int(progBarBG.frame.height)
        barWidth = Int(progBarBG.frame.width)
        progMask.image = UIImage(named: "progressBar2.png")
        progLabel.backgroundColor = UIColor.white
        progBarBG.addSubview(progLabel)
        progLabel.frame = CGRect(x: 0, y: 0, width: 0, height: barHeight)
        progLabel.addSubview(progMask)
        progMask.frame = CGRect(x: 0, y: 0, width: barWidth, height: barHeight)
        progLabel.mask = progMask
    }
    
    func showProgBar(){
        updateProgBar()
    }
    
    func fadeInNoteStreak(){
        if freeplayGame.start != true {
            updateNoteStreak()
            self.noteStreakImage.isHidden = false
            UIView.animate(withDuration: 2, animations: {
                self.noteStreakLabel.alpha = 1
                self.noteStreakImage.alpha = 1
            }, completion: { finished in
                
            })
        }
        
    }
    
    func fadeOutNoteStreak(){
        updateNoteStreak()
        let radians = CGFloat(Double.pi / 180) * 30
        let radians2 = CGFloat(Double.pi / 180) * -10
        let radians3 = CGFloat(Double.pi / 180) * 9.2
        UIView.animate(withDuration: 0.1, delay:0, animations: {
            self.noteStreakLabel.transform = CGAffineTransform(rotationAngle: radians)
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, delay:0, animations: {
                self.noteStreakLabel.transform = CGAffineTransform(rotationAngle: radians2)
            }, completion: { finished in
                UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                    self.noteStreakLabel.transform = CGAffineTransform(rotationAngle: radians3)
                }, completion: { finished in
                    UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(4), animations: {
                        self.noteStreakLabel.alpha = 0
                        self.noteStreakImage.alpha = 0
                    }, completion: { finished in
                        
                    })
                })
            })
        })
    }
    
    func updateNoteStreak(){
        self.noteStreakLabel.text = String(allNoteStreak)
    }
    
    @IBOutlet weak var BG: UIImageView!
    func updateProgBar(){
        UIView.animate(withDuration: 1, animations: {
            self.progLabel.frame.size.width = CGFloat((self.progBarBG.frame.width / 8)*CGFloat(self.roundCount))
        }, completion: { finished in

        })
    }
    
    func killButtons(clickable: Bool){
        var i = 1
        while i < buttonHolders.count {
            buttonHolders[i].isEnabled = clickable
            i += 1
        }
    }
    
    func hideButtons(){
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.bottomButtonsLight.alpha = 0
            self.bottomButtonLeft.alpha = 0
            self.bottomButtonMiddle.alpha = 0
            self.bottomButtonRight.alpha = 0
            self.buttonLabel1.alpha = 0
            self.buttonLabel2.alpha = 0
            self.buttonLabel3.alpha = 0
            self.progLabel.alpha = 0
            self.progBarBG.alpha = 0
            self.progBG.alpha = 0
        }, completion: { finished in
            
        })
    }
    
    func highlightButtons(correct: Int, incorrect: Int){
        let buttonImages = [bottomButtonLeft, bottomButtonLeft, bottomButtonMiddle, bottomButtonRight]
        let correctButton:UIImageView = buttonImages[correct]!
        let incorrectButton:UIImageView = buttonImages[incorrect]!
        UIView.animate(withDuration: 1, animations: {
            incorrectButton.alpha = 0.5
        }, completion: { finished in
            correctButton.alpha = 0.5
            incorrectButton.alpha = 1
            UIView.animate(withDuration: 1, animations: {
                correctButton.alpha = 1
            }, completion: { finished in
            
            })
        })
    }
    
    func addInsight(correct: Bool, noteChosen: String, correctNote: String){
        let insightWidth = note_width / 2
        if correct == true {
            let insight1 = UIImageView()
            let note_x = (noteHolders[roundCount-1].frame.origin.x) + (insightWidth-(insightWidth/2))
            print("Note Width = \(insightWidth)")
            insight1.frame = CGRect(x: note_x, y: 0, width: insightWidth, height: insightWidth)
            insight1.image = UIImage(named: "noteAnswerText_\(correctNote).png")
            scrollView.addSubview(insight1)
        } else {
            let insight2 = UIImageView()
            let note_x2 = (noteHolders[roundCount-1].frame.origin.x) + (insightWidth)
            print("Note Width when wrong = \(insightWidth)")
            insight2.frame = CGRect(x: note_x2, y: 0, width: insightWidth, height: insightWidth)
            insight2.image = UIImage(named: "noteAnswerText_\(correctNote).png")
            scrollView.addSubview(insight2)
        }
    }
    
    @objc func changeButtonColors(){
        let rand = Int(arc4random_uniform(3))
        UIView.animate(withDuration: 2, animations: {
            self.buttonLabel1.textColor = self.colors[rand]
            self.buttonLabel2.textColor = self.colors[rand]
            self.buttonLabel3.textColor = self.colors[rand]
        }, completion: { finished in
            
        })
    }
    
    var runningScore = 0
    var endScore = UILabel()

    func drawRunningCount(){
        let runningCountView = UIView()
        runningCountView.frame = CGRect(x: screenWidth-(screenHeight*0.20), y: screenHeight-(screenHeight*0.20), width: screenHeight*0.20, height: screenHeight*0.20)
        
    }
    
    func showHighlights(){
        print("Show Highlights called. Count = \(highlightCount)")
        if highlightCount == 7 {
            drawRunningCount()
        }
        if highlightCount > 0 || highlightCount == 0 {
            print("highlightCount is now \(highlightCount) and is definitely not less than 0")
            if gameRecord[highlightCount] == 1 {
                runningScore += 1
                print(runningScore)
            } else {
                print(runningScore)
            }
            let frame = noteHolders[0].superview?.convert(noteHolders[highlightCount].frame, to: nil)
            let centerPoint = (screenWidth/2) - (noteHolders[highlightCount].frame.width / 2)
            let distToCenter = ((frame?.origin.x)! - centerPoint) + self.scrollView.contentOffset.x
            
            var yOffset:CGFloat = 0
            for lowNote in lowNotes {
                if notesInGame[highlightCount] == lowNote {
                    yOffset = 0 - (self.scrollView.frame.height - self.staveView.frame.height)
                }
            }
            
            UIView.animate(withDuration: 1, delay:0, animations: {
                self.scrollView.contentOffset.x = distToCenter;
                self.scrollView.contentOffset.y = yOffset
            }, completion: { finished in
                self.showAnswer()
                self.jumpOffStave(type: 1, target: self.noteHolders[self.highlightCount])
                
            })
            
        } else {
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.endGame(function: "EndGamePrompt")
            }
            
        }
        
    }
    func jumpOffStave(type: Int, target: UIImageView){

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
//        showAnswer()
        finalScoreLabel.text = "\(runningScore)"
        
        finalScoreLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 75.0)
        finalScoreLabel.font = noteStreakLabel.font.withSize(75.0)
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.finalScoreLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: { finished in
            
        })
        
        
        UIView.animate(withDuration: 1, delay:0, animations: {
            target.alpha = 0
            target.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180)*50)
        }, completion: { finished in
            
        })
        self.highlightCount -= 1
        self.showHighlights()
    }

    
    func showAnswer(){
        let noteNameLabel = UILabel()
        let target = noteHolders[highlightCount]
        let answer:String = noteNames[self.notesInGame[self.highlightCount]]!
        let currentNote = self.notesInGame[self.highlightCount]
        noteNameLabel.frame = CGRect(x: target.frame.origin.x, y: target.frame.origin.y, width: target.frame.width, height: target.frame.width)
        noteNameLabel.center.y = scrollView.frame.height * 0.47
        noteNameLabel.text = "\(answer)"
        noteNameLabel.textColor = UIColor.white
        noteNameLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 72.0)
        scrollView.addSubview(noteNameLabel)
        scrollView.bringSubview(toFront: noteNameLabel)
        noteNameLabel.textAlignment = .center
        noteNameLabel.font = noteNameLabel.font.withSize(30.0)
        noteNameLabel.alpha = 0
        let labelScale = noteNameLabel.font.pointSize / noteNameLabel.font.pointSize
        UIView.animate(withDuration: 1, delay:0, animations: {
            noteNameLabel.alpha = 1
            noteNameLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: { finished in

        })
    }
    
    var finalScoreLabel = UILabel()
    let bg1 = UIImageView()
    let bg2 = UIImageView()
    var h:CGFloat = 0.0
    
    func showFinalScore(){
        
        h = screenHeight*0.75
        bg1.image = UIImage(named: "endScoreCircle1.png")
        bg2.image = UIImage(named: "endScoreCircle2.png")
        bg1.frame = CGRect(x: screenWidth+h, y: 0-h, width: h, height: h)
        bg2.frame = CGRect(x: screenWidth+h, y: 0-h, width: h, height: h)
        finalScoreLabel.frame = CGRect(x: h*0.1, y: h*0.4, width: h/2, height: h/2)
        finalScoreLabel.text = "\(runningScore)/8"
        finalScoreLabel.textColor = UIColor.white
        finalScoreLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 80.0)
        finalScoreLabel.font = noteStreakLabel.font.withSize(80.0)
        finalScoreLabel.textAlignment = .center
        self.view.addSubview(bg1)
        self.view.addSubview(bg2)
        bg2.addSubview(finalScoreLabel)
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.bg1.center = CGPoint(x: self.screenWidth, y: 0)
            self.bg2.center = CGPoint(x: self.screenWidth, y: 0)
        }, completion: { finished in
            
        })
    }
    
    func hideFinalScore(){
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.bg1.center = CGPoint(x: self.screenWidth + 400, y: -400)
            self.bg2.center = CGPoint(x: self.screenWidth + 400, y: -400)
            self.finalScoreLabel.frame = CGRect(x: (self.h*0.1)+400, y: (self.h*0.4)-400, width: self.h/2, height: self.h/2)
        }, completion: { finished in
            
        })
    }
    
    func setLabelDetails(target: UILabel, fontSize: CGFloat, color: UIColor, textAlign: NSTextAlignment, labelFrame: CGRect, center: CGPoint){
        target.frame = labelFrame
        target.textColor = color
        target.center = center
        target.font = UIFont(name: "Futura-CondensedExtraBold", size: fontSize)
        target.font = target.font.withSize(fontSize)
        target.textAlignment = textAlign
    }
    
    
    func addButton(target: UIButton, title: String, fontSize: CGFloat, color: UIColor, textAlign: NSTextAlignment, labelFrame: CGRect, center: CGPoint, tag: Int, targetSubView: UIView){
        target.frame = labelFrame
        target.center = center
        target.titleLabel?.textColor = color
        target.setTitleColor(color, for: .normal)
        target.setTitle(title, for: .normal)
        target.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: fontSize)
        target.titleLabel?.textAlignment = textAlign
        target.addTarget(self, action: #selector(endButtonClicked), for: .touchUpInside)
        target.tag = tag
        targetSubView.addSubview(target)
    }
    
    func fadeButtons(toggle: String, picked: Int){
        print("HERE I AM!!!! \(picked)")
        if(toggle == "on"){
            buttonLabel1.alpha = 1
            buttonLabel2.alpha = 1
            buttonLabel3.alpha = 1
            buttonActive = true
        } else {
            buttonLabel1.alpha = 0.5
            buttonLabel2.alpha = 0.5
            buttonLabel3.alpha = 0.5
            buttonActive = false
            if picked == 1 {
                buttonLabel1.alpha = 1
            }
            if picked == 2 {
                buttonLabel2.alpha = 1
            }
            if picked == 3 {
                buttonLabel3.alpha = 1
            }
        }
    }
    
    //to keep my sanity I will put all the end pop up elements here.
    
    let egWindow = UIView()
    let bgCover = UIView()
    let egTitle = UILabel()
    let egBodyText = UILabel()
    let egButton1 = UIButton()
    let egButton2 = UIButton()
    
    
    func showEndPopUp(){
        var score = 0
        for answer in gameRecord {
            if answer == 1 {
                score += 1
            }
        }
        
        if score == 8 {
            egTitle.text = "Perfect!!"
            egBodyText.text = "You didn't get a single note wrong that time! Maybe you should try some new notes?"
        }
        
        if score == 7 {
            egTitle.text = "Great work!"
            egBodyText.text = "You only got one note wrong that time! One more try?"
        }
        
        if score > 4 && score < 7 {
            egTitle.text = "Good work"
            egBodyText.text = "You only got \(8-score) wrong that time. Want to try again to see if you can get a perfect round?"
        }
        
        if score > 2 && score < 5 {
            egTitle.text = "Well done!"
            egBodyText.text = "You got \(8-score) out of 8 that time - some of those seemed tricky! The more you practice the easier they will get. Keep going!"
        }
        
        if score >= 0 && score < 3 {
            egTitle.text = "Keep trying!"
            egBodyText.text = "You got \(8-score) out of 8 that time. Do you need to relearn some of those before trying again?"
        }
        
        
        view.addSubview(bgCover)
        view.addSubview(egWindow)
        egWindow.addSubview(egTitle)
        egWindow.addSubview(egButton1)
        egWindow.addSubview(egButton2)
        egWindow.addSubview(egBodyText)
        
        egWindow.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.7, height: screenHeight*0.6)
        bgCover.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        egTitle.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.7, height: egWindow.frame.size.height*0.25)
        egBodyText.frame = CGRect(x: egWindow.frame.size.width*0.08, y: egWindow.frame.size.height*0.24, width: egWindow.frame.size.width*0.84, height: egWindow.frame.size.height*0.59)
        egButton1.frame = CGRect(x: 0, y: egWindow.frame.size.height*0.84, width: egWindow.frame.size.width * 0.503, height: egWindow.frame.size.height*0.16)
        egButton2.frame = CGRect(x: egWindow.frame.size.width * 0.497, y: egWindow.frame.size.height*0.84, width: egWindow.frame.size.width * 0.503, height: egWindow.frame.size.height*0.16)
        egButton1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        egButton2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        egWindow.center = CGPoint(x: screenWidth*0.5, y: 0-screenHeight)
        egWindow.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        egWindow.layer.cornerRadius = egWindow.frame.size.height * 0.12
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            bgCover.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = 0.9
            //always fill the view
            blurEffectView.frame = self.bgCover.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            bgCover.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            bgCover.backgroundColor = .black
        }
        
        egWindow.layer.masksToBounds = true
        
        
        egTitle.font = UIFont(name: "Futura-Bold", size: 45)!
        egTitle.textColor = UIColor.white
        egTitle.textAlignment = .center
//        egTitle.layer.backgroundColor = UIColor.red.cgColor
        egTitle.addKern(2)
        
        
        egBodyText.font = UIFont(name: "Futura-Medium", size: 35)!
        egBodyText.textColor = UIColor.white
        egBodyText.textAlignment = .justified
        egBodyText.addKern(1.1)
        egBodyText.numberOfLines = 0
        egBodyText.lineBreakMode = .byWordWrapping
        egBodyText.sizeToFit()
        
        egButton1.setTitle("PLAY AGAIN", for: .normal)
        egButton2.setTitle("PICK NEW NOTES", for: .normal)
        
        egButton1.titleLabel?.font = UIFont(name: "Futura-Bold", size: 25)!
        egButton1.titleLabel?.textColor = UIColor.orange
        egButton1.titleLabel?.textAlignment = .center
        //        egTitle.layer.backgroundColor = UIColor.red.cgColor
        egButton1.titleLabel?.addKern(2)
        egButton2.titleLabel?.font = UIFont(name: "Futura-Bold", size: 25)!
        egButton2.titleLabel?.textColor = UIColor.white
        egButton2.titleLabel?.textAlignment = .center
        //        egTitle.layer.backgroundColor = UIColor.red.cgColor
        egButton2.titleLabel?.addKern(2)
        egButton1.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        egButton2.addTarget(self, action: #selector(reselectNotes), for: .touchUpInside)
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.egWindow.center.y = self.screenHeight * 0.5
        }, completion: { finished in
            
        })
    }
    
    @objc public func playAgain(_ sender:UIButton!) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesViewController") as! notesViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @objc public func reselectNotes(_ sender:UIButton!) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "selectNotesViewController") as! selectNotesViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
 */
}
