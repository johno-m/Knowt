//
//  drawNoteTutorial.swift
//  Reading Music Tests
//
//  Created by John Mckay on 15/02/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class DrawNoteTutorial : UIView {

    var sS : CGSize!
    var tutorialBG : UIImageView!
    var tutorialImage : UIImageView!
    var tutorialControls : UIView!
    var tutorialWindow : UIView!
    var activePage = 0
    var indicators = [UIButton]()
    var tutorialImagePoints = [CGFloat]()
    var cP : CGPoint!
    
    init(sS: CGSize){
        let frame = CGRect(x: 0, y: 0, width: sS.width, height: sS.height)
        super.init(frame: frame)
        self.sS = sS
        
        tutorialWindow = UIView(frame: CGRect(x: 0, y: sS.height * 0.043, width: sS.height * 0.78, height: sS.height * 0.76))
        tutorialWindow.clipsToBounds = true
        tutorialWindow.center.x = sS.width * 0.5
        
        tutorialBG = UIImageView(frame: CGRect(x: 0, y: sS.height * 0.04, width: sS.height * 0.8, height: sS.height * 0.8))
        tutorialBG.image = UIImage(named: "dn-tut-bg")!
        tutorialBG.center = tutorialWindow.center
        tutorialBG.alpha = 0.9
        
        self.addSubview(tutorialBG)
        self.addSubview(tutorialWindow)
        
        let cP = CGPoint(x: tutorialWindow.frame.width * 0.5, y: tutorialWindow.frame.height * 0.5)
        self.cP = cP
        
        tutorialImage = UIImageView(frame: CGRect(x: 0, y: 0, width: (sS.height * 0.8)*5, height: sS.height * 0.8))
        
        tutorialImagePoints.append(0 + (tutorialImage.frame.height * 2))
        tutorialImagePoints.append(0 + (tutorialImage.frame.height * 1))
        tutorialImagePoints.append(0.0)
        tutorialImagePoints.append(0 - (tutorialImage.frame.height * 1))
        tutorialImagePoints.append(0 - (tutorialImage.frame.height * 2))
        
        tutorialImage.image = UIImage(named: "dn-tut")
        tutorialImage.center.x = cP.x + tutorialImagePoints[0]
        tutorialImage.center.y = cP.y
        tutorialWindow.addSubview(tutorialImage)
        
        print("tutorialImagePoints[0] = \(tutorialImagePoints[0])")
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.addGestureRecognizer(swipeRight)
        setIndicators()
        
        
    }
    
    func setIndicators(){
        indicators = [
            buildIndicator(count: 0),
            buildIndicator(count: 1),
            buildIndicator(count: 2),
            buildIndicator(count: 3),
            buildIndicator(count: 4)
        ]
        var indicatorCenters = [
            CGPoint(x: (sS.width * 0.5) - ((indicators[0].frame.width * 1.6) * 2), y: sS.height * 0.86),
            CGPoint(x: (sS.width * 0.5) - ((indicators[0].frame.width * 1.6) * 1), y: sS.height * 0.86),
            CGPoint(x: (sS.width * 0.5) - ((indicators[0].frame.width * 1.6) * 0), y: sS.height * 0.86),
            CGPoint(x: (sS.width * 0.5) + ((indicators[0].frame.width * 1.6) * 1), y: sS.height * 0.86),
            CGPoint(x: (sS.width * 0.5) + ((indicators[0].frame.width * 1.6) * 2), y: sS.height * 0.86)
        ]
        var i = 0
        for indicator in indicators {
            indicator.center = indicatorCenters[i]
            self.addSubview(indicator)
            
            indicator.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            i += 1
        }
    }
    
    @objc func buttonPressed(sender:UIButton){
        changePage(direction: "button", tag: sender.tag)
    }
    
    func buildIndicator(count: Int) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: sS.height * 0.02, height: sS.height * 0.02))
        if count == 0 {
            button.setImage(UIImage(named: "pageIndActive"), for: .normal)
        } else {
            button.setImage(UIImage(named: "pageIndInactive"), for: .normal)
        }
        
        button.tag = count
        
        return button
    }
    
    func changePage(direction: String, tag: Int){
        
        var i = 0
        
        if direction == "left" {
            activePage += 1
        } else if direction == "right" {
            activePage -= 1
        } else if direction == "button" {
            activePage = tag
        }
        for indicator in indicators {
            indicator.setImage(UIImage(named: "pageIndInactive"), for: .normal)
            i += 1
        }
        indicators[activePage].setImage(UIImage(named: "pageIndActive"), for: .normal)
        
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.tutorialImage.center.x = self.cP.x + self.tutorialImagePoints[self.activePage]
        }, completion: { finished in

        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if activePage > 0 {
                
                changePage(direction: "right", tag: 0)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if activePage < 4 {
                
                changePage(direction: "left", tag: 0)
            }
        }
    }
    
    func remove(){
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.removeFromSuperview()
        })
        
    }
    
    
    
}
