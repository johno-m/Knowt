//
//  fingerIndicator.swift
//  Reading Music Tests
//
//  Created by John Mckay on 10/02/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class FingerIndicator : UIView {
    var backgroundImage : UIImageView!
    var backgroundImageColor : UIView!
    var pC1 = UIView()
    var pC2 = UIView()
    var movementPath = UIBezierPath()
    var repeatPulse = false
    
    init(sS: CGSize, cP: CGPoint, path: UIBezierPath){
        let frame = CGRect(x: 0, y: 0, width: sS.height * 0.08, height: sS.height * 0.08)
        super.init(frame: frame)
        setImage()
        backgroundColor = UIColor.white
        layer.cornerRadius = self.frame.width * 0.5
        self.center = cP
        pulse()
        self.movementPath = path
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move(){
        self.alpha = 0
        UIView.animate(withDuration: 1.5, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.alpha = 1
        }, completion: { finished in
            self.repeatPulse = true
            self.pulse()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
            animation.duration = 3
            animation.repeatCount = 0
            animation.path = self.movementPath.cgPath
            self.layer.add(animation, forKey: nil)
            
            UIView.animate(withDuration: 0.5, delay:2.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
                self.alpha = 0
            }, completion: { finished in
                self.removeFromSuperview()
            })
        }
        
    }
    
    func pulseCircle() -> UIView {
        var pC = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        pC.backgroundColor = UIColor.white
        pC.layer.cornerRadius = self.frame.width / 2
        return pC
    }
    
    func pulse(){
        pC1 = pulseCircle()
        pC2 = pulseCircle()
        self.addSubview(pC1)
        self.addSubview(pC2)
        UIView.animate(withDuration: 1.3, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.pC1.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.pC1.alpha = 0
            self.pC1.center.x += 5
            self.pC1.center.y += 3
        }, completion: { finished in

        })
        UIView.animate(withDuration: 1.3, delay:0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.pC2.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.pC2.alpha = 0
            self.pC2.center.x -= 3
            self.pC2.center.y -= 5
        }, completion: { finished in
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { // change 2 to desired number of seconds
            if self.repeatPulse {
                self.pulse()
            }
        }
    }
    
    
    func setImage(){
        backgroundImage = UIImageView(frame: self.frame)
        backgroundImage.image = UIImage(named: "fingerIndicator")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backgroundImage.tintColor = grey
        self.addSubview(backgroundImage)
    }
    
}
