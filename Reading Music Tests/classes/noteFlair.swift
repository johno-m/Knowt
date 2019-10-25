//
//  noteFlair.swift
//  Reading Music Tests
//
//  Created by John Mckay on 27/01/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

// add some text coming off the notes saying "Excellent" or things like that

import Foundation
import UIKit

class NoteFlair : UIView {
    
    var flairText = SpringLabel()
    
    init(note: Note2, outcome: String, noteStreak: Int){
        super.init(frame: CGRect(x: 0, y: 0, width: note.frame.width * 5, height: note.frame.width * 1.5))
        self.backgroundColor = UIColor.clear
        flairText = SpringLabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        flairText.text = selectMessage(note: note, outcome: outcome, noteStreak: noteStreak)
        flairText.textColor = UIColor.white
        flairText.font = UIFont(name: "Futura-Bold", size: 40)
        flairText.adjustsFontSizeToFitWidth = true
        flairText.numberOfLines = 0
        flairText.minimumScaleFactor = 0.1
        flairText.textAlignment = .center
        self.addSubview(flairText)
        
        self.alpha = 0
        
        self.center.x = note.center.x
        self.center.y = note.center.y
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    func startAnimation(){
        self.flairText.animation = "pop"
        self.flairText.delay = 1.1
        self.flairText.duration = 0.5
        self.flairText.animate()
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.center.y -= self.frame.height
            self.alpha = 1
        }, completion: { finished in
            
            UIView.animate(withDuration: 2, delay:0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.center.y -= self.frame.width * 1
                self.alpha = 0
            }, completion: { finished in
                self.removeFromSuperview()
            })
        })
    }
    
    func selectMessage(note: Note2, outcome: String, noteStreak: Int) -> String {
        var message = ""
        var storedNote = [String : noteStruct]()
        if note.stave == "treble" {
            storedNote = trebleNotes
        }
        
        if note.stave == "bass" {
            storedNote = bassNotes
        }
        
        if noteStreak == 3 {
            message = "3 IN A ROW"
        }
        var randomNumber = Int(arc4random_uniform(4))
        
        if randomNumber == 1 {
            print("random number = \(randomNumber)")
            if noteStreak > 10 {
                message = "ON A ROLL"
            }
            
            if (storedNote[note.note]?.correctRunningCount)! > 5 {
                message = "SUPER\nSTREAK"
            }
        }
        
        
        
        
        return message
    }
    
}

//class StarFlair : UIView {
//    
//    init(sS: CGRect){
//        super.init()
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        backgroundColor = UIColor.clear
//    }
//    
//}
