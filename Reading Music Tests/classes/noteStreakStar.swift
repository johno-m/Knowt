//
//  noteStreakStar.swift
//  Reading Music Tests
//
//  Created by John Mckay on 01/02/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class NoteStreakStar : UIView {
    
    var star = CAShapeLayer()
    var starMask = CAShapeLayer()
    var fill = UIView()
    var prevStreak = noteStreakMarkers[0]
    var nextStreak = noteStreakMarkers[0]
    var numberLabel : SpringLabel!
    var popLabel : SpringLabel!
    var shown = false
    var centerPointPermanent = CGPoint()
    
    init(sS: CGSize) {
        let starDimension = sS.width * 0.25
        print("sS == \(starDimension)")
        super.init(frame: CGRect(x: 0, y: 0, width: starDimension, height: starDimension))
        self.star = drawStar(bounds: self.bounds.size)
        self.starMask = drawStar(bounds: self.bounds.size)
        self.layer.addSublayer(star)
        self.fill.layer.mask = starMask
        self.star.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        numberLabel = makeLabel()
        
        self.isHidden = true
        addFill(bounds: self.bounds.size)
        print("FRAME SIZE 1 : \(self.bounds.size)")
        findMarker(i: 0)
        self.addSubview(numberLabel)
        self.popLabel = makeLabel()
        self.addSubview(self.popLabel)
        self.popLabel.text = numberLabel.text
        self.popLabel.isHidden = true
        place(sS: sS)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeLabel() -> SpringLabel {
        let newLabel = SpringLabel()
        newLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.5, height: self.frame.width * 0.5)
        newLabel.center = CGPoint(x: self.center.x, y: self.center.y * 1.1)
        newLabel.text = "0"
        newLabel.font = UIFont(name: "Futura-Bold", size: 40)
        newLabel.textColor = UIColor.white
        newLabel.numberOfLines = 0
        newLabel.adjustsFontSizeToFitWidth = true
        newLabel.textAlignment = .center
        return newLabel
    }

    func show(){
        if shown == false {
            shown = true
            self.isHidden = false
            UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.frame.origin = CGPoint(x: sS.width * 0.81, y: sS.height * 0.73)
            }, completion: { finished in
                UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180) * 12)
                }, completion: { finished in
                    
                    self.animateFill()
                })
            })
        }
        
    }
    
    func hide(){
        if shown == true {
            shown = false
            numberLabel.animation = "pop"
            numberLabel.duration = 1
            numberLabel.animate()
            UIView.animate(withDuration: 1, delay:1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.frame.origin = CGPoint(x: sS.width * 0.86, y: sS.height)
            }, completion: { finished in
                self.isHidden = true
            })
        }
        
    }
    
    func addFill(bounds:CGSize){
        fill.frame = CGRect(x: 0, y: 0, width: 0, height: bounds.height)
        fill.backgroundColor = orange
        self.addSubview(fill)
    }
    
    func findMarker(i: Int){
        if usrInf.noteStreak == 0 {
            nextStreak = noteStreakMarkers[1]
            print("note streak is 0")
        } else {
            if usrInf.noteStreak < noteStreakMarkers[i+1] {
                prevStreak = noteStreakMarkers[i]
                nextStreak = noteStreakMarkers[i+1]
                print("previous streak level was \(prevStreak)")
                print("next streak level was \(nextStreak)")
            } else {
                findMarker(i: i+1)
            }
        }
    }
    
    func drawStar(bounds:CGSize) -> CAShapeLayer {
        let shape = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width * 0.5, y: 0))
        path.addLine(to: CGPoint(x: bounds.width * 0.625, y: bounds.height * 0.39))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.39))
        path.addLine(to: CGPoint(x: bounds.width * 0.7, y: bounds.height * 0.615))
        path.addLine(to: CGPoint(x: bounds.width * 0.82, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.765))
        path.addLine(to: CGPoint(x: bounds.width * 0.18, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width * 0.3, y: bounds.height * 0.615))
        path.addLine(to: CGPoint(x: 0, y: bounds.height * 0.39))
        path.addLine(to: CGPoint(x: bounds.width * 0.375, y: bounds.height * 0.39))
        path.fill()
        path.close()
        
        shape.path = path.cgPath
        return shape
    }
    
    func animateFill(){
        let amountToEarn = self.nextStreak - self.prevStreak
        let amountEarnt = usrInf.noteStreak - self.prevStreak
        let perc:CGFloat = (CGFloat(amountEarnt) / CGFloat(amountToEarn))
        
        UIView.animate(withDuration: 1, delay:0, animations: {
            self.fill.frame.size.width = self.frame.width * perc
            print("filling the meter: \(perc)")
            
        }, completion: { finished in
            if perc > 0.99 {
                self.fill.backgroundColor = orange
            }
        })
    }
    
    func place(sS: CGSize){
        self.frame.origin = CGPoint(x: sS.width * 0.86, y: sS.height)
    }
    
    func updateNumber(num: Int){
        numberLabel.text = "\(num)"
        
    }
    
    func shake(){
        UIView.animate(withDuration: 0.3, delay:0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.transform = CGAffineTransform(rotationAngle: CGFloat(12 * CGFloat.pi / 180))
        }, completion: { finished in
            UIView.animate(withDuration: 0.3, delay:0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.transform = CGAffineTransform(rotationAngle: CGFloat(12 * CGFloat.pi / 180))
            }, completion: { finished in
                self.pop()
            })
        })
    }
    func pop(){
        self.popLabel.text = self.numberLabel.text
        self.popLabel.isHidden = false
        self.popLabel.alpha = 1
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.popLabel.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.popLabel.alpha = 0
        }, completion: { finished in
            self.popLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.popLabel.alpha = 0
        })
        
//        let newImage = copyView(viewforCopy: popLabel)
//        self.addSubview(newImage)
//        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
//            newImage.frame.origin = CGPoint(x: 10, y: 10)
//        }, completion: { finished in
//            
//        })
    }
    



}
