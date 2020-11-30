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

extension UIColor {
    func interpolateRGBColorTo(_ end: UIColor, fraction: CGFloat) -> UIColor? {
        let f = min(max(0, fraction), 1)

        guard let c1 = self.cgColor.components, let c2 = end.cgColor.components else { return nil }

        let r: CGFloat = CGFloat(c1[0] + (c2[0] - c1[0]) * f)
        let g: CGFloat = CGFloat(c1[1] + (c2[1] - c1[1]) * f)
        let b: CGFloat = CGFloat(c1[2] + (c2[2] - c1[2]) * f)
        let a: CGFloat = CGFloat(c1[3] + (c2[3] - c1[3]) * f)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

func hex(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
