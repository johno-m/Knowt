////
////  ShapeToDraw.swift
////  Reading Music Tests
////
////  Created by John Mckay on 11/02/2019.
////  Copyright © 2019 John Mckay. All rights reserved.
////

// Drawn Shape refers only to tutorial shapes the user has been shown how to draw.

import Foundation
import UIKit

class ShapeToDraw: UIView {
    var orientation : String!
    var path = BezierPath()
    var shape = CAShapeLayer()
    var stemPath = UIBezierPath()
    var stemShape = CAShapeLayer()
    var noteStartPoint = CGPoint()
    var offset: CGFloat!
    var lineColor = UIColor.white
    var lineWidth:CGFloat = 4.2
    var shapeName = "nothing"
    let guideShape = CAShapeLayer()
    var guidePath = UIBezierPath()
    var cP : CGPoint!
    var rRatio : CGFloat!
    
    var startHere : UIImageView!
    var startHereInd : Bool!
    
    init(sS: CGSize, cP: CGPoint, orientation: String, shapeName: String, rRatio: CGFloat, delay: TimeInterval, dashed: Bool, withGuide: Bool, guideShape: String, shown: Bool, startHereInd: Bool? = false){
        let r:CGFloat = sS.height * rRatio
        print(sS)
        super.init(frame: CGRect(x: 0, y: 0, width: sS.width, height: sS.height))
        self.shapeName = shapeName
        self.orientation = orientation
        self.startHereInd = startHereInd
        self.cP = cP
        self.rRatio = rRatio
        createPaths(sS: sS, centerPoint: CGPoint(x: sS.width * cP.x, y: sS.height * cP.y), r: r)
        if shown {
            if shapeName == "wave" {
                self.drawWave(sS: sS, delay: 2, duration: 2, dashed: true)
            }
            if shapeName == "note" {
                self.drawShape(path: self.path, shape: self.shape, delay: delay, duration: 1, r: r, dashed: dashed, withGuide: withGuide, guideShape: guideShape, sS: sS)
            }
            if shapeName == "circle" {
                self.drawShape(path: self.path, shape: self.shape, delay: delay, duration: 1, r: r, dashed: dashed, withGuide: withGuide, guideShape: guideShape, sS: sS)
            }
            if shapeName == "stem" {
                self.drawShape(path: self.path, shape: self.shape, delay: delay, duration: 1, r: r, dashed: dashed, withGuide: withGuide, guideShape: guideShape, sS: sS)
            }
        }
        
        if startHereInd != nil && startHereInd == true {
            showStartHereInd(r: r, cP: CGPoint(x: sS.width * cP.x, y: sS.height * cP.y))
        }
        
        path.generateLookupTable()
        print(path.lookupTable)
        /*
        for point in path.lookupTable {
            let dot = CAShapeLayer()
            dot.path = UIBezierPath(ovalIn: CGRect(x: point.x-4, y: point.y-4, width: 8, height: 8)).cgPath
            
            dot.fillColor = UIColor.red.cgColor
            self.layer.addSublayer(dot)
        }
         */
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func showStartHereInd(r:CGFloat, cP: CGPoint){
        startHere = UIImageView(image: UIImage(named: "startHere"))
        startHere.frame = CGRect(x: cP.x + (r*1.2), y: cP.y - (r * 0.5), width: ((r / 6) * 7.15), height: r)
        self.addSubview(startHere)
        startHere.alpha = 0
        UIView.animate(withDuration: 1, delay:3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.startHere.alpha = 1
        }, completion: { finished in
            
        })
    }
    
    func hideStartHereInd(){
        if startHereInd {
            UIView.animate(withDuration: 1, delay:3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.startHere.alpha = 0
            }, completion: { finished in
                
            })
        }
        
    }
    
    func createPaths(sS: CGSize, centerPoint: CGPoint, r: CGFloat){
        //radius of the circle. Based of height of space
        
        let cP:CGPoint = centerPoint
        
        var orientationVariable:CGFloat = 0.0
        
        if self.orientation == "up" {
            orientationVariable = 0 - (r*3.5)
            noteStartPoint = CGPoint(x: cP.x + r, y: cP.y)
            path = BezierPath(arcCenter: CGPoint(x: cP.x, y: cP.y),
                                      radius: r,
                                      startAngle: CGFloat(0.0) * .pi / 180,
                                      endAngle: CGFloat(360.0) * .pi / 180,
                                      clockwise: false)
        } else {
            orientationVariable = (r*3.5)
            noteStartPoint = CGPoint(x: cP.x - r, y: cP.y)
            path = BezierPath(arcCenter: CGPoint(x: cP.x, y: cP.y),
                                      radius: r,
                                      startAngle: CGFloat(180.0) * .pi / 180,
                                      endAngle: CGFloat(181.0) * .pi / 180,
                                      clockwise: false)
        }
        //
        //        let cp1 = CGPoint(x: noteStartPoint.x, y: noteStartPoint.y)
        //        let cp2 = CGPoint(x: noteStartPoint.x + (orientationVariable * 0.07), y: noteStartPoint.y + orientationVariable)
        //
        print("self.shapeName = \(self.shapeName)")
        if self.shapeName == "note" {
            path.addLine(to: CGPoint(x: noteStartPoint.x, y: noteStartPoint.y + (orientationVariable * 0.5)))
            path.addLine(to: CGPoint(x: noteStartPoint.x, y: noteStartPoint.y + orientationVariable))
        }
        if self.shapeName == "stem" {
            path.removeAllPoints()
            path.move(to: noteStartPoint)
            path.addLine(to: CGPoint(x: noteStartPoint.x, y: noteStartPoint.y + orientationVariable))
        }
    }
    
    
    func drawShape(path: BezierPath, shape: CAShapeLayer, delay: TimeInterval, duration: TimeInterval, r: CGFloat, dashed: Bool, withGuide: Bool, guideShape: String, sS: CGSize){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { // change 2 to desired number of seconds
            let circumference = ((.pi * 2) * r) / 15
            print("r = \(r)")
            print("circumference = \(circumference)")
            shape.path = path.cgPath
            shape.strokeColor = self.lineColor.cgColor
            shape.fillColor = UIColor.clear.cgColor
            shape.lineCap = "round"
            shape.lineWidth = self.lineWidth
            
            if dashed { shape.lineDashPattern = [circumference * 0.55, circumference * 0.45] as [NSNumber] }
            
            self.layer.addSublayer(shape)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = duration
            shape.add(animation, forKey: "MyAnimation")
            self.path = path
            if withGuide { self.drawGuideShape(sS: sS, delay: 2, duration: 2, r: r, dashed: false, shapeToDraw: guideShape) }
        }
    }
    
    func drawWave(sS: CGSize, delay: TimeInterval, duration: TimeInterval, dashed: Bool){
        let path = BezierPath()
        let shape = CAShapeLayer()
        
        var points = [
            CGPoint(x: sS.width * 0.2, y: sS.height * 0.4),
            CGPoint(x: sS.width * 0.4, y: sS.height * 0.6),
            CGPoint(x: sS.width * 0.6, y: sS.height * 0.4),
            CGPoint(x: sS.width * 0.8, y: sS.height * 0.6)
        ]
        let pointAdd = sS.width * 0.1
        
        path.move(to: points[0])
        noteStartPoint = points[0]
        path.addCurve(to: points[1], controlPoint1: CGPoint(x: points[0].x + pointAdd, y:  points[0].y), controlPoint2: CGPoint(x:  points[1].x - pointAdd, y:  points[1].y))
        path.addCurve(to: points[2], controlPoint1: CGPoint(x: points[1].x + pointAdd, y:  points[1].y), controlPoint2: CGPoint(x:  points[2].x - pointAdd, y:  points[2].y))
        path.addCurve(to: points[3], controlPoint1: CGPoint(x: points[2].x + pointAdd, y:  points[2].y), controlPoint2: CGPoint(x:  points[3].x - pointAdd, y:  points[3].y))
        shape.path = path.cgPath
        shape.strokeColor = self.lineColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = "round"
        shape.lineWidth = self.lineWidth
        if dashed { shape.lineDashPattern = [25, 45] as [NSNumber] }
        self.layer.addSublayer(shape)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = duration
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shape.add(animation, forKey: "MyAnimation")
        
        self.path = path
        
        
    }
    
    func fade(delay: TimeInterval, alpha: CGFloat){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.alpha = alpha
            }, completion: { finished in
                
            })
        }
    }

    
    func drawGuideShape(sS: CGSize, delay: TimeInterval, duration: TimeInterval, r: CGFloat, dashed: Bool, shapeToDraw: String){
        
        let newR = r*1.2
        let dot1r = r*1.1
        let dot2r = r*1.3
        
        let a = CGFloat(305.0) * .pi / 180
        let a2 = CGFloat(300.0) * .pi / 180
        
        let cP = CGPoint(x: self.noteStartPoint.x - r, y: self.noteStartPoint.y)
        
        let arrowX1 = CGFloat(cP.x + dot1r*cos(a))
        let arrowY1 = CGFloat(cP.y + dot1r*sin(a))
        let arrowX2 = CGFloat(cP.x + newR*cos(a2))
        let arrowY2 = CGFloat(cP.y + newR*sin(a2))
        let arrowX3 = CGFloat(cP.x + dot2r*cos(a))
        let arrowY3 = CGFloat(cP.y + dot2r*sin(a))
        
        
        if shapeToDraw == "circle" {
            guidePath = UIBezierPath(arcCenter: CGPoint(x: cP.x, y: cP.y),
                                radius: newR,
                                startAngle: CGFloat(340.0) * .pi / 180,
                                endAngle: CGFloat(300.0) * .pi / 180,
                                clockwise: false)
            guidePath.addLine(to: CGPoint(x: arrowX1, y: arrowY1))
            guidePath.move(to: CGPoint(x: arrowX2, y: arrowY2))
            guidePath.addLine(to: CGPoint(x: arrowX3, y: arrowY3))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { // change 2 to desired number of seconds
            let circumference = ((.pi * 2) * r) / 15
            print("r = \(r)")
            print("circumference = \(circumference)")
            self.guideShape.path = self.guidePath.cgPath
            self.guideShape.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
            self.guideShape.fillColor = UIColor.clear.cgColor
            self.guideShape.lineCap = "round"
            self.guideShape.lineWidth = self.lineWidth * 1.5
            self.guideShape.lineJoin = kCALineJoinRound
            
            self.layer.addSublayer(self.guideShape)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = duration * 0.5
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

            self.guideShape.add(animation, forKey: "MyAnimation")
        }
    }
    
    func halfFade(delay: TimeInterval){
        UIView.animate(withDuration: 2, delay:delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.alpha = 0.5
        })
        
    }
    
    func showStartHere(){
        
    }
    
    func remove(){
        UIView.animate(withDuration: 1, delay:0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.removeFromSuperview()
        })
        
    }
    
    func hideGuide(){
        guideShape.removeFromSuperlayer()
    }
    
}

