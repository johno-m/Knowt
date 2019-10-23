//
//  varStore.swift
//  Reading Music Tests
//
//  Created by John Mckay on 25/07/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import Foundation
import UIKit

var correctCount = 0
var totalRounds = 8

// Promotion variables
var promotionClass = "none"
var previousLevel = 0
var allNoteStreak = 0
var userMaxLevelReached:[Bool] = [false, false, false]
var noteGameType = "none" // free or note

struct gameStruct {
    var start: Bool
    var notes: [String]
}

var freeplayGame : gameStruct!

// this is the variable that shows the final screen has been shown so you can stop it showing again
var finalScreenPlayedOut = false

var allNotes = [String : Int]()

var unlockedNotes: [String:Int] = [
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


var notesCorrectCount: [String:Int] = [
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
// array to store each time they have seen the note
var notesCount: [String:Int] = [
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
// array to store a streak of incorrect notes - if streak reaches 3 then play extra help game
var noteStreak: [String:Int] = [
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

var noteTutPos: [String:CGFloat] = [
    "E3" : 0.809,
    "F3" : 0.778,
    "G3" : 0.750,
    "A3" : 0.724,
    "B3" : 0.697,
    "C4" : 0.669,
    "D4" : 0.642,
    "E4" : 0.616,
    "F4" : 0.589,
    "G4" : 0.561,
    "A4" : 0.534,
    "B4" : 0.507,
    "C5" : 0.475,
    "D5" : 0.446,
    "E5" : 0.415,
    "F5" : 0.396,
    "G5" : 0.362,
    "A5" : 0.344
]

var answerPos: [String:CGFloat] = [
    "E3" : 0.809,
    "F3" : 0.778,
    "G3" : 0.750,
    "A3" : 0.724,
    "B3" : 0.697,
    "C4" : 0.669,
    "D4" : 0.642,
    "E4" : 0.616,
    "F4" : 0.589,
    "G4" : 0.561,
    "A4" : 0.534,
    "B4" : 0.507,
    "C5" : 0.475,
    "D5" : 0.446,
    "E5" : 0.415,
    "F5" : 0.396,
    "G5" : 0.362,
    "A5" : 0.344
]

var noteHumanNames: [String:String] = [
    "E3" : "low",
    "F3" : "low",
    "G3" : "low",
    "A3" : "low",
    "B3" : "low",
    "C4" : "low",
    "D4" : "low",
    "E4" : "middle",
    "F4" : "middle",
    "G4" : "middle",
    "A4" : "middle",
    "B4" : "middle",
    "C5" : "middle",
    "D5" : "middle",
    "E5" : "high",
    "F5" : "high",
    "G5" : "high",
    "A5" : "high"
]

var noteTutImg: [String:String] = [
    "E3" : "shas_note",
    "F3" : "shas_note",
    "G3" : "shas_note",
    "A3" : "shas_note",
    "B3" : "shas_note",
    "C4" : "shas_note",
    "D4" : "shas_note",
    "E4" : "shas_note",
    "F4" : "shas_note",
    "G4" : "shas_note",
    "A4" : "shas_note",
    "B4" : "shas_note",
    "C5" : "shas_note2",
    "D5" : "shas_note2",
    "E5" : "shas_note2",
    "F5" : "shas_note2",
    "G5" : "shas_note2",
    "A5" : "shas_note2"
]

var notePrefix: [String:String] = [
    "E3" : "a low",
    "F3" : "a low",
    "G3" : "a low",
    "A3" : "a low",
    "B3" : "a low",
    "C4" : "a low",
    "D4" : "a low",
    "E4" : "a middle",
    "F4" : "an",
    "G4" : "a",
    "A4" : "an",
    "B4" : "a",
    "C5" : "a",
    "D5" : "a",
    "E5" : "a high",
    "F5" : "a high",
    "G5" : "a high",
    "A5" : "a high"
]

let noneNoteLevels = [
    ["E3", "B2", "G2"],
    ["A2", "C2"],
    ["D2", "E1"],
    ["A1", "D1"],
    ["E2", "F3"],
    ["G3", "C1"],
    ["F2", "A3"],
    ["F1", "G1"],
    ["B1"]
]

let guitarNoteLevels = [
    ["G4", "B4", "E5"],
    ["A4", "C5"],
    ["D5", "D4"],
    ["F5", "G5"],
    ["E3", "A3"],
    ["E4", "F4"],
    ["F3", "G3"],
    ["B3", "C4"],
    ["A5", "B5", "C6"]
]

let guitarNoteLevelsBASS = [
    ["A2", "C3", "E3"],
    ["G3", "D3"],
    ["G2", "B2"],
    ["F3", "A3"],
    ["B3", "C4"],
    ["E2", "F2"],
    ["C2", "D2"],
    ["B1"]
]

let violinNoteLevels = [
    ["E3", "A2", "D1"],
    ["G1", "B2"],
    ["C2", "D2"],
    ["F3", "G3"],
    ["E2", "F2"],
    ["A3", "G2"],
    ["A1", "C1"],
    ["B1", "E1"],
    ["F1"]
]

let ukuleleNoteLevels = [
    ["A2", "E2", "C1"],
    ["B2", "G2"],
    ["C2", "D2"],
    ["D1", "F2"],
    ["E3", "F3"],
    ["G3", "A3"],
    ["A1", "B1"],
    ["G1", "F1"],
    ["E1"]
]

let pianoNoteLevels = [
    ["B2", "C2", "D2"],
    ["A2", "G2"],
    ["E2", "F2"],
    ["E3", "F3"],
    ["C1", "D1"],
    ["G3", "A3"],
    ["A1", "B1"],
    ["G1", "F1"],
    ["E1"]
]

let noteLevelList = [
    "Guitar" : guitarNoteLevels,
    "Violin" : violinNoteLevels,
    "Piano" : pianoNoteLevels,
    "Ukulele" : ukuleleNoteLevels,
    "None" : noneNoteLevels
]

let noteLevelListBASS = [
    "Guitar" : guitarNoteLevelsBASS,
    "Violin" : violinNoteLevels,
    "Piano" : pianoNoteLevels,
    "Ukulele" : ukuleleNoteLevels,
    "None" : noneNoteLevels
]

let noteList = ["E3","F3","G3","A3","B3","C4","D4","E4","F4","G4","A4","B4","C5","D5","E5","F5","G5","A5", "B5" , "C6" ]
let noteList2 = ["E1","F1","G1","A1","B1","C1","D1","E2","F2","G2","A2","B2","C2","D2","E3","F3","G3","A3","B3"]
let dualStaveNoteList = [
    ["B3","B1"],
    ["C4","C2"],
    ["D4","D2"],
    ["E4","E2"],
    ["F4","F2"],
    ["G4","G2"],
    ["A4","A2"],
    ["B4","B2"],
    ["C5","C3"],
    ["D5","D3"],
    ["E5","E3"],
    ["F5","F3"],
    ["G5","G3"],
    ["A5","A3"],
    ["B5","B3"]
]

let noteNames: [String:String] = [
    "E3" : "E",
    "F3" : "F",
    "G3" : "G",
    "A3" : "A",
    "B3" : "B",
    "C4" : "C",
    "D4" : "D",
    "E4" : "E",
    "F4" : "F",
    "G4" : "G",
    "A4" : "A",
    "B4" : "B",
    "C5" : "C",
    "D5" : "D",
    "E5" : "E",
    "F5" : "F",
    "G5" : "G",
    "A5" : "A"
]

// this is a badly named variable. These are the ones used for testing after tutorials
let noteHintsBass : [String:[String]] = [
    "B1" : ["A3", "G4"],
    "C2" : ["A3", "G4"],
    "D2" : ["A3", "G4"],
    "E2" : ["A3", "G4"],
    "F2" : ["A3", "G4"],
    "G2" : ["A3", "G4"],
    "A2" : ["A3", "G4"],
    "B2" : ["A3", "G4"],
    "C3" : ["E3", "F4"],
    "D3" : ["A3", "E3"],
    "E3" : ["B3", "C4"],
    "F3" : ["A3", "G4"],
    "G3" : ["D4", "G3"],
    "A3" : ["A3", "G4"],
    "B3" : ["A3", "G4"],
    "C4" : ["A3", "G4"],
    "E3" : ["A4", "C4"],
    "A4" : ["G4", "E3"],
    "B4" : ["A4", "E4"],
    "C4" : ["A4", "G4"]
]

let noteHints : [String:[String]] = [
    "E3" : ["A3", "G4"],
    "F3" : ["C3", "A3"],
    "G3" : ["E3", "G4"],
    "A3" : ["D3", "G4"],
    "B3" : ["A3", "G4"],
    "C4" : ["A3", "G4"],
    "D4" : ["A4", "G4"],
    "E4" : ["A4", "G4"],
    "F4" : ["E4", "A4"],
    "G4" : ["A4", "C4"],
    "A4" : ["B4", "C4"],
    "B4" : ["A4", "G4"],
    "C5" : ["D4", "G5"],
    "D5" : ["A3", "G4"],
    "E5" : ["C5", "G5"],
    "F5" : ["C5", "B5"],
    "G5" : ["D5", "A5"],
    "A5" : ["G4", "E3"],
    "B5" : ["A5", "E4"],
    "C6" : ["A5", "B5"]
]


let trebleNotesLedgerLines : [String:Int] = [
    "E1" : 4,
    "F1" : 4,
    "G1" : 3,
    "A1" : 3,
    "B1" : 2,
    "C1" : 2,
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
    "A3" : 1
]

// note end of game data

var notesInGameTop3: [String] = ["G2", "B2", "E3"]

// note tutorial bits

var introTutorialCompleted = false

// rhythm questions - name, value, score, img, tut image, fake answer 2 3 & 4

var rhythmQuestions = [
    ["crochet", "1 beat", "rhythm-crochet.png", "rhythm-crochet-tutorial.png"],
    ["crochet rest", "1 beat", "rhythm-crochet-rest.png", "rhythm-crochet-rest-tutorial.png"],
    ["minim", "2 beats", "rhythm-minim.png", "rhythm-minim-tutorial.png"],
    ["minim rest", "2 beat", "rhythm-minim-rest.png", "rhythm-minim-rest-tutorial.png"],
]

var rhythmGame2Questions = [
    ["rhythm-crochet.png", "1 beat", "2 beats", "3 beats", "4 beats"],
    ["rhythm-crochet-rest.png", "1 beat", "2 beats", "3 beats", "4 beats"],
    ["rhythm-minim.png", "1 beat", "2 beats", "3 beats", "4 beats"],
    ["rhythm-minim-rest.png", "1 beat", "2 beats", "3 beats", "4 beats"]
]

var rhythmGame2Answers = [1,1,2,2]

var rhythmQuestionList = [
    ["Which note lasts for 1 beat?", "rhythm-crochet.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 1 beat?", "rhythm-crochet-rest.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 2 beats?", "rhythm-minim.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 2 beats?", "rhythm-minim-rest.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for a 1/2 beat?", "rhythm-quaver.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for a 1/2 beat?", "rhythm-quaver-rest.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 3 beats?", "rhythm-dotted-minim.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 3 beats?", "rhythm-dotted-minim-rest.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 4 beats?", "rhythm-semibreve.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"],
    ["Which note lasts for 4 beats?", "rhythm-semibreve-rest.png", "rhythm-minim.png", "rhythm-semibreve.png", "rhythm-quaver.png"]
]

var beatCountArr:[[Int]] = [
    [1,3,7],
    [1,3,7],
    [1,3,7],
    [1,3,5,7],
    [1,3,5,7],
    [1,3,5,7],
    [1,3,5,7],
    [1,3,5,7],
    [1,3,5,7],
    [1,5,7],
    [1,5,7],
    [1,5,7],
    [1,2,3,5,7],
    [1,5,7],
    [1,5,7],
    [1,3,4,5,7,8],
    [1,3,4,5,7,8],
    [1,3,4,5,7,8],
    [1,2,3,5,6,7],
    [1,2,3,5,6,7],
    [1,2,3,5,6,7],
    [1,4,5,7],
    [1,4,5,7],
    [1,4,5,7]
]

var rhythmTestList = [
    ["Which note lies on the first beat?", "1", "rhythm-beat-test1.png", "rhythmAnswer1"],
    ["Which note lies on the second beat?", "3", "rhythm-beat-test1.png", "rhythmAnswer3"],
    ["Which note lies on the forth beat?", "7", "rhythm-beat-test1.png", "rhythmAnswer7"],
    ["Which note lies on the first beat?", "1", "rhythm-beat-test2.png", "rhythmAnswer1"],
    ["Which note lies on the second beat?", "3", "rhythm-beat-test2.png", "rhythmAnswer3"],
    ["Which note lies on the forth beat?", "7", "rhythm-beat-test2.png", "rhythmAnswer7"],
    ["Which note lies on the first beat?", "1", "rhythm-beat-test3.png", "rhythmAnswer1"],
    ["Which note lies on the second beat?", "3", "rhythm-beat-test3.png", "rhythmAnswer3"],
    ["Which note lies on the forth beat?", "7", "rhythm-beat-test3.png", "rhythmAnswer7"],
    ["Which note lies on the first beat?", "1", "rhythm-beat-test4.png", "rhythmAnswer1"],
    ["Which note lies on the third beat?", "5", "rhythm-beat-test4.png", "rhythmAnswer5"],
    ["Which note lies on the forth beat?", "7", "rhythm-beat-test4.png", "rhythmAnswer7"],
    ["Which note lies on the 'and' of beat one?", "2", "rhythm-beat-test5.png", "rhythmAnswer2"],
    ["Which note lies on the second beat?", "3", "rhythm-beat-test5.png", "rhythmAnswer3"],
    ["Which note lies on the forth beat?", "7", "rhythm-beat-test5.png", "rhythmAnswer7"],
    ["Which note lies on the 'and' of the second beat?", "4", "rhythm-beat-test6.png", "rhythmAnswer4"],
    ["Which note lies on the 'and' of the forth beat?", "8", "rhythm-beat-test6.png", "rhythmAnswer8"],
    ["Which note lies on the third beat?", "5", "rhythm-beat-test6.png", "rhythmAnswer5"],
    ["Which note lies on the first beat?", "1", "rhythm-beat-test7.png", "rhythmAnswer1"],
    ["Which note lies on the second beat?", "3", "rhythm-beat-test7.png", "rhythmAnswer3"],
    ["Which note lies on the 'and' of the third beat?", "6", "rhythm-beat-test7.png", "rhythmAnswer6"],
    ["Which note lies on the forth beat?", "7", "rhythm-beat-test8.png", "rhythmAnswer7"],
    ["Which note lies on the 'and' of the second beat?", "4", "rhythm-beat-test8.png", "rhythmAnswer4"],
    ["Which note lies on the 'and' of the third beat?", "5", "rhythm-beat-test8.png", "rhythmAnswer5"]
]

var rhythmScores = [0,0,0,0]
var rhythmDifficulty = [4, 8]

var rhythmRound = 0
var rhythmGameScore = 0
var rhythmGame1count = 0
var rhythmGame2count = 0
var rhythmGame3count = 0
var rhythmGame1NotesInGame = [[String]]()

var game1pool = [Int]()
var game2pool = [Int]()
var actionToDo = "none"

// user variables

var instrument:String = "Unset"
var userLevel = [0,0,0]
let userLevelTargets = [200, 410, 610, 830, 1030, 1210, 1370, 1570, 1740]
// notes, theory, rhythm

var lastSaved = Date().ticks

var prompts = [
    "selectNotes" : false
    ]

//var storeList = [allNotes, notesCount, noteStreak, allNoteStreak, instrument, userLevel] as [Any]



func resetScore(){
//    for note in noteList {
//        allNotes[note] = 0
//        notesCount[note] = 0
//        notesCorrectCount[note] = 0
//        noteStreak[note] = 0
//        userLevel = [0,0,0]
//    }
//    saveUserInf()
}

func checkUnlockedNotes(level: Int) -> [String]{
    var notes = [String]()
    for i in 0...level {
        if instrument == "Unset" {
            instrument = "Guitar"
        }
        var levelList = noteLevelList[instrument]
        notes += levelList![i]
    }
    
    return notes
}



extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

extension UIButton{
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(kCTKernAttributeName as NSAttributedStringKey, value: spacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UILabel {
    
    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    
    }
    
}


extension UILabel {
    
    /**
     Add kerning to a UILabel's existing `attributedText`
     - note: If `UILabel.attributedText` has not been set, the `UILabel.text`
     value will be returned from `attributedText` by default
     - note: This method must be called each time `UILabel.text` or
     `UILabel.attributedText` has been set
     - parameter kernValue: The value of the kerning to add
     */
    func addKern(_ kernValue: CGFloat) {
        guard let attributedText = attributedText,
            attributedText.string.count > 0,
            let fullRange = attributedText.string.range(of: attributedText.string) else {
                return
        }
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.addAttributes([
            .kern: kernValue
            ], range: NSRange(fullRange, in: attributedText.string))
        self.attributedText = updatedText
    }
}

func addButton(btn: UIButton, labelText: String, bgColor: UIColor, labelColor: UIColor?, textSize: CGFloat, btnWidth: CGFloat?, pos: CGPoint, multiline: Bool) -> UIButton {
    var lblColor = UIColor()
    if labelColor == nil {
        lblColor = UIColor(red:0.19, green:0.21, blue:0.22, alpha:1.0)
    } else {
        lblColor = labelColor!
    }
    btn.setTitle(labelText, for: .normal)
    btn.titleLabel?.numberOfLines = 0
    btn.titleLabel?.lineBreakMode = NSLineBreakMode.byCharWrapping
    btn.titleLabel?.font = UIFont(name: "Futura-Bold", size: textSize)
    
    btn.titleLabel?.baselineAdjustment = .none
    
    btn.layer.backgroundColor = bgColor.cgColor
    btn.setTitleColor(lblColor, for: .normal)
    btn.titleLabel?.addKern(2)
    if multiline {
        btn.titleLabel?.setLineSpacing(lineHeightMultiple: 0.8)
    }
    
    btn.titleLabel?.sizeToFit()
    btn.contentHorizontalAlignment = .center
    btn.titleLabel?.textAlignment = .center
    var setWidth = CGFloat()
    if btnWidth == nil {
        setWidth = ((btn.titleLabel?.frame.width)! * 1.4)
    } else {
        setWidth = btnWidth!
    }
    btn.frame = CGRect(x: 0, y: 0, width: setWidth, height: ((btn.titleLabel?.frame.height)! * 1.35))
    btn.center = CGPoint(x: pos.x, y: pos.y)
    btn.layer.cornerRadius = btn.layer.frame.height / 2
    if multiline {
        btn.titleEdgeInsets = UIEdgeInsetsMake((btn.layer.frame.size.height - (btn.titleLabel?.layer.frame.height)!)*0.45, 0.0, 0.0, 0.0)
    }
    
    return btn
}

// 2.0 coding from here on

let noteStreakMarkers = [0, 15, 30, 50, 70, 100, 130, 160, 200, 250, 300, 350, 400, 460, 520, 600, 700, 800, 900, 1000, 1000000000]

var saveVersion = 2.0

struct noteStruct {
    var noteName : String //E1
    var humanNoteName : String  //E
    var descNoteName : String //Low E
    var stavePosition : Int
    var correctCount : Int
    var incorrectCount : Int
    var correctRunningCount : Int
    var incorrectRunningCount : Int
    var score : Int
    var rotated : Bool
    var ledgers : Int
    var ledgerOffset : Bool
    var stavePos : Int
    var responseTimes : [Double]
}

struct userInfo {
    var instrument : String
    var treblelevel : Int
    var basslevel : Int
    var noteStreak : Int
    var prefStave : String
    var name : String
    var tutsComplete : [String : Bool]
    var lastSave : TimeInterval
    var prompts : [String : Bool] // prompts the user may see and if they have been seen or not
    var userTrebleMaxLevelReached : Bool
    var userBassMaxLevelReached : Bool
}

struct userPrefs {
    var staveType : String
    var volume : Int
}

var usrInf = userInfo(instrument: "unset", treblelevel: 0, basslevel: 0, noteStreak: 0, prefStave: "treble", name: "unset", tutsComplete: ["any" : false], lastSave: NSDate().timeIntervalSince1970, prompts: [String:Bool](), userTrebleMaxLevelReached: false, userBassMaxLevelReached: false)
var usrInfDefault = userInfo(instrument: "unset", treblelevel: 0, basslevel: 0, noteStreak: 0, prefStave: "treble", name: "unset", tutsComplete: [String : Bool](), lastSave: NSDate().timeIntervalSince1970, prompts: [String:Bool](), userTrebleMaxLevelReached: false, userBassMaxLevelReached: false)

var trebleNotes:[String : noteStruct] = [
    "E3" : noteStruct(noteName: "E3", humanNoteName: "E", descNoteName: "Low E", stavePosition: 19, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 3, ledgerOffset: false, stavePos: 11, responseTimes: []),
    "F3" : noteStruct(noteName: "F3", humanNoteName: "F", descNoteName: "Low F", stavePosition: 18, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 3, ledgerOffset: true, stavePos: 10, responseTimes: []),
    "G3" : noteStruct(noteName: "G3", humanNoteName: "G", descNoteName: "Low G", stavePosition: 17, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 2, ledgerOffset: false, stavePos: 9, responseTimes: []),
    "A3" : noteStruct(noteName: "A3", humanNoteName: "A", descNoteName: "Low A", stavePosition: 16, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 2, ledgerOffset: true, stavePos: 8, responseTimes: []),
    "B3" : noteStruct(noteName: "B3", humanNoteName: "B", descNoteName: "Low B", stavePosition: 15, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 1, ledgerOffset: false, stavePos: 7, responseTimes: []),
    "C4" : noteStruct(noteName: "C4", humanNoteName: "C", descNoteName: "Low C", stavePosition: 14, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 1, ledgerOffset: true, stavePos: 6, responseTimes: []),
    "D4" : noteStruct(noteName: "D4", humanNoteName: "D", descNoteName: "Low D", stavePosition: 13, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 5, responseTimes: []),
    "E4" : noteStruct(noteName: "E4", humanNoteName: "E", descNoteName: "Middle E", stavePosition: 12, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 4, responseTimes: []),
    "F4" : noteStruct(noteName: "F4", humanNoteName: "F", descNoteName: "Middle F", stavePosition: 11, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 3, responseTimes: []),
    "G4" : noteStruct(noteName: "G4", humanNoteName: "G", descNoteName: "Middle G", stavePosition: 10, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 2, responseTimes: []),
    "A4" : noteStruct(noteName: "A4", humanNoteName: "A", descNoteName: "Middle A", stavePosition: 9, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 1, responseTimes: []),
    "B4" : noteStruct(noteName: "B4", humanNoteName: "B", descNoteName: "Middle B", stavePosition: 8, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 0, responseTimes: []),
    "C5" : noteStruct(noteName: "C5", humanNoteName: "C", descNoteName: "Middle C", stavePosition: 7, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -1, responseTimes: []),
    "D5" : noteStruct(noteName: "D5", humanNoteName: "D", descNoteName: "Middle D", stavePosition: 6, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -2, responseTimes: []),
    "E5" : noteStruct(noteName: "E5", humanNoteName: "E", descNoteName: "High E", stavePosition: 5, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -3, responseTimes: []),
    "F5" : noteStruct(noteName: "F5", humanNoteName: "F", descNoteName: "High F", stavePosition: 4, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -4, responseTimes: []),
    "G5" : noteStruct(noteName: "G5", humanNoteName: "G", descNoteName: "High G", stavePosition: 3, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -5, responseTimes: []),
    "A5" : noteStruct(noteName: "A5", humanNoteName: "A", descNoteName: "High A", stavePosition: 2, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 1, ledgerOffset: true, stavePos: -6, responseTimes: []),
    "B5" : noteStruct(noteName: "B5", humanNoteName: "B", descNoteName: "High B", stavePosition: 1, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 1, ledgerOffset: false, stavePos: -7, responseTimes: []),
    "C6" : noteStruct(noteName: "C6", humanNoteName: "C", descNoteName: "High C", stavePosition: 0, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 2, ledgerOffset: true, stavePos: -8, responseTimes: [])
]

var bassNotes:[String : noteStruct] = [
    "B1" : noteStruct(noteName: "B1", humanNoteName: "B", descNoteName: "Low E", stavePosition: 15, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 2, ledgerOffset: false, stavePos:9, responseTimes: []),
    "C2" : noteStruct(noteName: "C2", humanNoteName: "C", descNoteName: "Low G", stavePosition: 14, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 2, ledgerOffset: true, stavePos: 8, responseTimes: []),
    "D2" : noteStruct(noteName: "D2", humanNoteName: "D", descNoteName: "Low G", stavePosition: 13, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 1, ledgerOffset: false, stavePos: 7, responseTimes: []),
    "E2" : noteStruct(noteName: "E2", humanNoteName: "E", descNoteName: "Low A", stavePosition: 12, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 1, ledgerOffset: true, stavePos: 6, responseTimes: []),
    "F2" : noteStruct(noteName: "F2", humanNoteName: "F", descNoteName: "Low B", stavePosition: 11, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 5, responseTimes: []),
    "G2" : noteStruct(noteName: "G2", humanNoteName: "G", descNoteName: "Low C", stavePosition: 10, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 4, responseTimes: []),
    "A2" : noteStruct(noteName: "A2", humanNoteName: "A", descNoteName: "Low D", stavePosition: 9, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 3, responseTimes: []),
    "B2" : noteStruct(noteName: "B2", humanNoteName: "B", descNoteName: "Middle E", stavePosition: 8, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 2, responseTimes: []),
    "C3" : noteStruct(noteName: "C3", humanNoteName: "C", descNoteName: "Middle F", stavePosition: 7, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 1, responseTimes: []),
    "D3" : noteStruct(noteName: "D3", humanNoteName: "D", descNoteName: "Middle G", stavePosition: 6, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: false, ledgers: 0, ledgerOffset: false, stavePos: 0, responseTimes: []),
    "E3" : noteStruct(noteName: "E3", humanNoteName: "E", descNoteName: "Middle A", stavePosition: 5, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -1, responseTimes: []),
    "F3" : noteStruct(noteName: "F3", humanNoteName: "F", descNoteName: "Middle B", stavePosition: 4, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -2, responseTimes: []),
    "G3" : noteStruct(noteName: "G3", humanNoteName: "G", descNoteName: "Middle C", stavePosition: 3, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -3, responseTimes: []),
    "A3" : noteStruct(noteName: "A3", humanNoteName: "A", descNoteName: "Middle D", stavePosition: 2, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -4, responseTimes: []),
    "B3" : noteStruct(noteName: "B3", humanNoteName: "B", descNoteName: "High E", stavePosition: 1, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 0, ledgerOffset: false, stavePos: -5, responseTimes: []),
    "C4" : noteStruct(noteName: "C4", humanNoteName: "C", descNoteName: "High F", stavePosition: 0, correctCount: 0, incorrectCount: 0, correctRunningCount: 0, incorrectRunningCount: 0, score: 0, rotated: true, ledgers: 4, ledgerOffset: true, stavePos: -6, responseTimes: [])
]

func addResponseTime(note: String, newTime: Double){
    // note must be scientific name
    print("Adding new time - \(newTime)")
    if identifyStave(noteName: note) == "treble" {
        trebleNotes[note]!.responseTimes.append(newTime)
        if trebleNotes[note]!.responseTimes.count > 6 {
            trebleNotes[note]!.responseTimes.remove(at: 0)
        }
        print("Saved response times: \(trebleNotes[note]!.responseTimes)")
    } else {
        bassNotes[note]!.responseTimes.append(newTime)
        if bassNotes[note]!.responseTimes.count > 6 {
            bassNotes[note]!.responseTimes.remove(at: 0)
        }
        print("Saved response times: \(trebleNotes[note]!.responseTimes)")
    }
}

func averageResponseTime(note: String) -> Double {
    var averageTime:Double = 0.0
    if identifyStave(noteName: note) == "treble" {
        for time in trebleNotes[note]!.responseTimes {
            averageTime += time
        }
    } else {
        for time in bassNotes[note]!.responseTimes {
            averageTime += time
        }
    }
    return averageTime
}

func identifyStave(noteName: String) -> String {
    var result = "treble"
    
    for note in bassNotes {
        if note.key == noteName {
            result = "bass"
        }
    }
    
    return result
}
