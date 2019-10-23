//
//  extensions.swift
//  Reading Music Tests
//
//  Created by John Mckay on 02/02/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        self.transform = CGAffineTransform(rotationAngle: CGFloat(angle * CGFloat.pi / 180))
    }

    func copyView(viewforCopy: UIView) -> UIView {
        viewforCopy.isHidden = false //The copy not works if is hidden, just prevention
        let viewCopy = viewforCopy.snapshotView(afterScreenUpdates: true)
        viewforCopy.isHidden = true
        return viewCopy!
    }
}


func listOfUnlockedNotes(stave: String) -> [String] {
    var listOfNotes = [String]()
    if stave == "treble" {
        let noteList = noteLevelList[usrInf.instrument]
        var i = 0
        for _ in 0...usrInf.treblelevel {
            for note in noteList![i] {
                listOfNotes.append(note)
            }
            i += 1
        }
    } else {
        let noteList = noteLevelListBASS[usrInf.instrument]
        var i = 0
        for _ in 0...usrInf.basslevel {
            for note in noteList![i] {
                listOfNotes.append(note)
            }
            i += 1
        }
    }
    
    return listOfNotes
}

func checkPromotionCriteria(stave: String) -> Bool {
    var result = true
    let unlockedNotes = listOfUnlockedNotes(stave: stave)
    
    if stave == "treble" {
        for note in unlockedNotes {
            if (trebleNotes[note]?.score)! < 200 {
                result = false
            }
        }
    } else {
        for note in unlockedNotes {
            if (bassNotes[note]?.score)! < 200 {
                result = false
            }
        }
    }
    
    return result
}



