//
//  loadsave.swift
//  Reading Music Tests
//
//  Created by John Mckay on 22/01/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

func loadUserInf(){
    
    var instrument : String
    var treblelevel : Int
    var basslevel : Int
    var noteStreak : Int
    var prefStave : String
    var name : String
    var tutsComplete : [String : Bool]
    var lastSave : TimeInterval
    var userTrebleMaxLevelReached : Bool
    var userBassMaxLevelReached : Bool
    var prompts : [String : Bool]
    var loadSuccessful = true
    
    var correctRunningNotes = [String : Int]()
    var incorrectRunningNotes = [String : Int]()
    var noteScores = [String : Int]()
    var trebleResponseTimes = [String : [Double]]()
    var bassResponseTimes = [String : [Double]]()
    
    var correctRunningNotes2 = [String : Int]()
    var incorrectRunningNotes2 = [String : Int]()
    var noteScores2 = [String : Int]()
    
    var saveKeys = [
        "instrument" : false,
        "trebleLevel" : false,
        "bassLevel" : false,
        "noteStreak" : false,
        "prefStave" : false,
        "name" : false,
        "tutsComplete" : false,
        "lastSave" : false,
        "prompts" : false,
        "userTrebleMaxLevelReached" : false,
        "userBassMaxLevelReached" : false,
        "correctNotes" : false,
        "incorrectNotes" : false,
        "correctRunningNotes" : false,
        "incorrectRunningNotes" : false,
        "noteScores" : false,
        "correctRunningNotes2" : false,
        "incorrectRunningNotes2" : false,
        "noteScores2" : false,
        "trebleResponseTimes" : false,
        "bassResponseTimes" : false
    ]
    
    let uD = UserDefaults.standard
    print("Loading variables... ")
    
    var unsaved = 0
    
    for key in saveKeys {
        if let _ = uD.object(forKey: key.key) {
            print("-- '\(key.key)' successfully loaded --")
            saveKeys[key.key] = true
        } else {
            print("++ '\(key.key)' save is corrupted ++")
            usrInf = usrInfDefault
            unsaved += 1
        }
    }
    if unsaved == saveKeys.count {
        usrInf = usrInfDefault
    } else {
        
        if saveKeys["instrument"]! {
            instrument = uD.object(forKey: "instrument") as! String
        } else {
            instrument = "Unset"
        }
        if saveKeys["trebleLevel"]! {
            treblelevel = uD.object(forKey: "trebleLevel") as! Int
        } else {
            treblelevel = 0
        }
        if saveKeys["bassLevel"]! {
            basslevel = uD.object(forKey: "bassLevel") as! Int
        } else {
            basslevel = 0
        }
        if saveKeys["noteStreak"]! {
            noteStreak = uD.object(forKey: "noteStreak") as! Int
        } else {
            noteStreak = 0
        }
        if saveKeys["prefStave"]! {
            prefStave = uD.object(forKey: "prefStave") as! String
        } else {
            prefStave = "treble"
        }
        if saveKeys["name"]! {
            name = uD.object(forKey: "name") as! String
        } else {
            name = ""
        }
        if saveKeys["tutsComplete"]! {
            tutsComplete = uD.object(forKey: "tutsComplete") as! [String : Bool]
        } else {
            tutsComplete = [String : Bool]()
        }
        if saveKeys["lastSave"]! {
            lastSave = uD.object(forKey: "lastSave") as! TimeInterval
        } else {
            lastSave = TimeInterval()
        }
        if saveKeys["instrument"]! {
            tutsComplete = uD.object(forKey: "tutsComplete") as! [String : Bool]
        } else {
            tutsComplete = [String : Bool]()
        }
        if saveKeys["userTrebleMaxLevelReached"]! {
            userTrebleMaxLevelReached = uD.object(forKey: "userTrebleMaxLevelReached") as! Bool
        } else {
            userTrebleMaxLevelReached = false
        }
        if saveKeys["userBassMaxLevelReached"]! {
            userBassMaxLevelReached = uD.object(forKey: "userBassMaxLevelReached") as! Bool
        } else {
            userBassMaxLevelReached = false
        }
        if saveKeys["prompts"]! {
            prompts = uD.object(forKey: "prompts") as! [String : Bool]
        } else {
            prompts = [String : Bool]()
        }
        if saveKeys["correctRunningNotes"]! {
            correctRunningNotes = uD.object(forKey: "correctRunningNotes") as! [String : Int]
            for note in trebleNotes {
                trebleNotes[note.key]?.correctRunningCount = correctRunningNotes[note.key]!
            }
        } else {
            correctRunningNotes = [String : Int]()
            for note in trebleNotes {
                trebleNotes[note.key]?.correctRunningCount = 0
            }
        }
        
        if saveKeys["incorrectRunningNotes"]! {
            incorrectRunningNotes = uD.object(forKey: "incorrectRunningNotes") as! [String : Int]
            for note in trebleNotes {
                trebleNotes[note.key]?.incorrectRunningCount = incorrectRunningNotes[note.key]!
            }
        } else {
            for note in trebleNotes {
                trebleNotes[note.key]?.incorrectRunningCount = 0
            }
        }
        if saveKeys["noteScores"]! {
            noteScores = uD.object(forKey: "noteScores") as! [String : Int]
            for note in trebleNotes {
                trebleNotes[note.key]?.score = noteScores[note.key]!
            }
        } else {
            for note in trebleNotes {
                trebleNotes[note.key]?.score = 0
            }
        }
        if saveKeys["trebleResponseTimes"]! {
            trebleResponseTimes = uD.object(forKey: "trebleResponseTimes") as! [String : [Double]]
            for note in trebleNotes {
                trebleNotes[note.key]?.responseTimes = trebleResponseTimes[note.key]!
            }
        } else {
            for note in trebleNotes {
                trebleNotes[note.key]?.responseTimes = [Double]()
            }
        }
        if saveKeys["bassResponseTimes"]! {
            bassResponseTimes = uD.object(forKey: "bassResponseTimes") as! [String : [Double]]
            for note in bassNotes {
                bassNotes[note.key]?.responseTimes = bassResponseTimes[note.key]!
            }
        } else {
            for note in bassNotes {
                bassNotes[note.key]?.responseTimes = [Double]()
            }
        }
        if saveKeys["correctRunningNotes2"]! {
            correctRunningNotes2 = uD.object(forKey: "correctRunningNotes2") as! [String : Int]
            for note in bassNotes {
                bassNotes[note.key]?.correctRunningCount = correctRunningNotes2[note.key]!
            }
        } else {
            for note in bassNotes {
                bassNotes[note.key]?.correctRunningCount = 0
            }
        }
        if saveKeys["incorrectRunningNotes2"]! {
            incorrectRunningNotes2 = uD.object(forKey: "incorrectRunningNotes2") as! [String : Int]
            for note in bassNotes {
                bassNotes[note.key]?.incorrectRunningCount = incorrectRunningNotes2[note.key]!
            }
        } else {
            for note in bassNotes {
                bassNotes[note.key]?.incorrectRunningCount = 0
            }
        }
        if saveKeys["noteScores2"]! {
            noteScores2 = uD.object(forKey: "noteScores2") as! [String : Int]
            for note in bassNotes {
                bassNotes[note.key]?.score = noteScores2[note.key]!
            }
        } else {
            for note in bassNotes {
                bassNotes[note.key]?.score = 0
            }
        }
        if saveKeys["instrument"]! {
            
        } else {
            
        }
        if saveKeys["instrument"]! {
            
        } else {
            
        }
        if saveKeys["instrument"]! {
            
        } else {
            
        }
        
        usrInf = userInfo(instrument: instrument, treblelevel: treblelevel, basslevel: basslevel, noteStreak: noteStreak, prefStave: prefStave, name: name, tutsComplete: tutsComplete, lastSave: lastSave, prompts: prompts, userTrebleMaxLevelReached: userTrebleMaxLevelReached, userBassMaxLevelReached: userBassMaxLevelReached)
        
    }
    
//    if saveKeys["correctRunningNotes"] && saveKeys["incorrectRunningNotes"] &&  {
//        for note in trebleNotes {
////            trebleNotes[note.key]?.correctRunningCount = correctRunningNotes[note.key]!
////            trebleNotes[note.key]?.incorrectRunningCount = incorrectRunningNotes[note.key]!
//            trebleNotes[note.key]?.score = noteScores[note.key]!
//            trebleNotes[note.key]?.responseTimes = trebleResponseTimes[note.key]!
//        }
//        for note in bassNotes {
//            bassNotes[note.key]?.correctRunningCount = correctRunningNotes2[note.key]!
//            bassNotes[note.key]?.incorrectRunningCount = incorrectRunningNotes2[note.key]!
//            bassNotes[note.key]?.score = noteScores2[note.key]!
//            bassNotes[note.key]?.responseTimes = bassResponseTimes[note.key]!
//        }
//    }
//
    
    
    
    for note in trebleNotes {
        print(note)
    }
    
}


func saveUserInf(){
    print("attempting to save")
    let uD = UserDefaults.standard
    uD.set(usrInf.instrument, forKey: "instrument")
    uD.set(usrInf.treblelevel, forKey: "trebleLevel")
    uD.set(usrInf.basslevel, forKey: "bassLevel")
    uD.set(usrInf.noteStreak, forKey: "noteStreak")
    uD.set(usrInf.prefStave, forKey: "prefStave")
    uD.set(usrInf.name, forKey: "name")
    uD.set(usrInf.tutsComplete, forKey: "tutsComplete")
    uD.set(usrInf.lastSave, forKey: "lastSave")
    uD.set(usrInf.prompts, forKey: "prompts")
    uD.set(usrInf.userTrebleMaxLevelReached, forKey: "userTrebleMaxLevelReached")
    uD.set(usrInf.userBassMaxLevelReached, forKey: "userBassMaxLevelReached")
    
    var correctRunningNotes = [String : Int]()
    var incorrectRunningNotes = [String : Int]()
    var noteScores = [String : Int]()
    var trebleResponseTimes = [String : [Double]]()
    var bassResponseTimes = [String : [Double]]()
    
    var correctRunningNotes2 = [String : Int]()
    var incorrectRunningNotes2 = [String : Int]()
    var noteScores2 = [String : Int]()
    
    for note in trebleNotes {
        correctRunningNotes[note.key] = note.value.correctRunningCount
        incorrectRunningNotes[note.key] = note.value.incorrectRunningCount
        noteScores[note.key] = note.value.score
        trebleResponseTimes[note.key] = note.value.responseTimes
    }
    
    for note in bassNotes {
        correctRunningNotes2[note.key] = note.value.correctRunningCount
        incorrectRunningNotes2[note.key] = note.value.incorrectRunningCount
        noteScores2[note.key] = note.value.score
        bassResponseTimes[note.key] = note.value.responseTimes
    }
    
    uD.set(correctRunningNotes, forKey: "correctRunningNotes")
    uD.set(incorrectRunningNotes, forKey: "incorrectRunningNotes")
    uD.set(noteScores, forKey: "noteScores")
    uD.set(trebleResponseTimes, forKey: "trebleResponseTimes")
    
    uD.set(correctRunningNotes2, forKey: "correctRunningNotes2")
    uD.set(incorrectRunningNotes2, forKey: "incorrectRunningNotes2")
    uD.set(noteScores2, forKey: "noteScores2")
    uD.set(bassResponseTimes, forKey: "bassResponseTimes")
    
    print("Save function called \(usrInf.instrument)")
}

func deleteUserInf(){
    for note in trebleNotes {
        trebleNotes[note.key]!.correctRunningCount = 0
        trebleNotes[note.key]!.incorrectRunningCount = 0
        trebleNotes[note.key]!.score = 0
        trebleNotes[note.key]!.responseTimes = [Double]()
    }
    usrInf = usrInfDefault
    saveUserInf()
}
