//
//  Flair.swift
//  Reading Music Tests
//
//  Created by John Mckay on 19/02/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

/**
 Flair appears over drawn objects to indicate success or fail.
 **/
class DrawNoteFlair : UIView {
    
    var flairText: UILabel!
    var sS: CGSize!
    var shape: CAShapeLayer!
    var success: Bool!
    
    init(sS: CGSize, success: Bool, text: String, path: UIBezierPath){
        let frame = CGRect(x: 0, y: 0, width: sS.width, height: sS.height)
        super.init(frame: frame)
        self.sS = sS
        self.shape = CAShapeLayer()
        self.shape.path = path.cgPath
        self.shape.fillColor = UIColor.clear.cgColor
        self.shape.strokeColor = UIColor.white.cgColor
        self.shape.lineWidth = 60.0
        self.shape.lineCap = "round"
        self.shape.lineJoin = kCALineJoinRound
        self.layer.addSublayer(shape)
        self.success = success
        pulseLine()
        flairText = setText(text: text, cP: CGPoint(x: sS.width * 0.5, y: sS.height * 0.5))
        self.addSubview(flairText)
        show(cP: CGPoint(x: sS.width * 0.5, y: sS.height * 0.5))
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setText(text: String, cP: CGPoint) -> UILabel {
        var newString = UILabel(frame: self.frame)
        newString.text = text
        newString.textColor = UIColor.white
        newString.font = UIFont(name: "Futura-CondensedExtraBold", size: 80)
        newString.adjustsFontSizeToFitWidth = true
        newString.numberOfLines = 0
        newString.minimumScaleFactor = 0.1
        newString.textAlignment = .center
        newString.alpha = 0
        return newString
    }
    
    func show(cP: CGPoint){
        UIView.animate(withDuration: 1, delay:0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.center.y -= self.sS.height*0.22
            self.flairText.alpha = 1
        }, completion: { finished in
            self.pulse(target: self.flairText, count: 0, limit: 4)
            UIView.animate(withDuration: 1, delay:3, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
                self.alpha = 0
            }, completion: { finished in
                self.removeFromSuperview()
            })
        })
    }
    
    /** Text will pulse **/
    func pulse(target: UILabel, count: Int, limit: Int){
        var newCount = count + 1
        var pulseView = self.copyView(viewforCopy: self)
        UIView.animate(withDuration: 1, delay:0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            pulseView.transform = CGAffineTransform(scaleX: 3, y: 3)
            pulseView.alpha = 0
            if newCount < limit { self.pulse(target: self.flairText, count: newCount, limit: limit) }
        }, completion: { finished in
            pulseView.removeFromSuperview()
            
        })
    }
    
    func pulseLine(){
        self.shape.lineWidth = 10.0
        
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.toValue = 100.0
        lineWidthAnimation.duration = 0.5
        lineWidthAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        lineWidthAnimation.autoreverses = false
        lineWidthAnimation.repeatCount = 1
        lineWidthAnimation.fillMode = kCAFillModeForwards
        lineWidthAnimation.isRemovedOnCompletion = true
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.duration = 0.5
        opacity.fillMode = kCAFillModeForwards
        opacity.isRemovedOnCompletion = false
        
        self.shape.add(opacity, forKey: "opacity")
        
        self.shape.add(lineWidthAnimation, forKey: "lineWidthAnimation")
        
        if success {
            // do nothing
        } else {
            self.shape.strokeColor = UIColor.red.cgColor
            
            let strokeColorAnimation = CABasicAnimation(keyPath: "strokeColor")
            strokeColorAnimation.toValue = UIColor.red.cgColor
            strokeColorAnimation.duration = 1.5
            strokeColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            strokeColorAnimation.autoreverses = true
            strokeColorAnimation.repeatCount = .greatestFiniteMagnitude
            
            self.shape.add(strokeColorAnimation, forKey: "strokeColorAnimation")
        }
    }
    
}
