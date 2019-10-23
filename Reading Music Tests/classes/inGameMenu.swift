//
//  inGameMenu.swift
//  Reading Music Tests
//
//  Created by John Mckay on 27/01/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

private var shadowLayer: CAShapeLayer!
private var cornerRadius: CGFloat = 25.0
private var fillColor: UIColor = .blue // the color applied to the shadowLayer, rather than the view's backgroundColor

class InGameMenu : UIView {
    var toggled = Bool()
    var buttons = [UIButton]()
    var clefBtnToggled1 = Bool()
    var clefBtnToggled2 = Bool()
    
    init(sS: CGSize){
        let boxHeight = sS.height*0.18 + sS.width*0.03
        super.init(frame: CGRect(x: sS.width*0.03, y: 0-boxHeight, width: sS.width*0.94, height: sS.height*0.18))
        toggled = false
        self.backgroundColor = UIColor.clear
        
        var bgLayer = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        bgLayer.layer.cornerRadius = bounds.height * 0.2
        bgLayer.layer.masksToBounds = true
        self.addSubview(bgLayer)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = 1
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.layer.cornerRadius = 50
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            bgLayer.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            bgLayer.backgroundColor = .black
        }
        
        self.layer.cornerRadius = bounds.height * 0.2
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height * 0.2).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 7
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
        let padding = bounds.height*0.08
        var buttonLayer = UIView()
        buttonLayer.frame = CGRect(x: padding, y: padding, width: bounds.width - padding*2, height: bounds.height - padding*2)
        buttonLayer.layer.cornerRadius = buttonLayer.frame.height * 0.2
        buttonLayer.backgroundColor = UIColor.clear
        buttonLayer.layer.masksToBounds = true
        self.addSubview(buttonLayer)
        
        let buttonWidth = (buttonLayer.frame.width - (padding*3)) / 4
        
        let highlighted = UIColor(red:0.00, green:0.58, blue:0.58, alpha:1.0)
        
        let buttonColours = [
            UIColor(red:1.00, green:0.58, blue:0.01, alpha:1.0),
            UIColor(red:0.08, green:0.79, blue:0.72, alpha:1.0),
            UIColor(red:0.08, green:0.79, blue:0.72, alpha:1.0),
            UIColor(red:0.65, green:0.91, blue:0.07, alpha:1.0),
            UIColor(red:0.59, green:0.13, blue:0.53, alpha:1.0)
        ]
        
        let buttonFrames = [
            CGRect(x: 0, y: 0, width: buttonWidth, height: buttonLayer.frame.height),
            CGRect(x: buttonWidth+padding, y: 0, width: buttonWidth/2-(padding/2), height: buttonLayer.frame.height),
            CGRect(x: buttonWidth+padding+(padding/2)+(buttonWidth/2), y: 0, width: buttonWidth/2-(padding/2), height: buttonLayer.frame.height),
            CGRect(x: buttonWidth*2+padding*2, y: 0, width: buttonWidth, height: buttonLayer.frame.height),
            CGRect(x: buttonWidth*3+padding*3, y: 0, width: buttonWidth, height: buttonLayer.frame.height)
        ]
        let buttonImages = [
            "backToMainMenu",
            "selectClefTreble",
            "selectClefBass",
            "restart",
            "volume3"
        ]
        for i in 0...4 {
            let button = UIButton()
            button.frame = buttonFrames[i]
            button.backgroundColor = buttonColours[i]
            button.setBackgroundImage(UIImage(named: "fractal_smaller"), for: .normal)
            button.contentMode = UIViewContentMode.scaleAspectFill
            button.tag = i
            button.setImage(UIImage(named: buttonImages[i]), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            
            print(i)
            print(usrInf.prefStave)
            if i == 1 && usrInf.prefStave == "treble" || i == 1 && usrInf.prefStave == "grand" {
                button.backgroundColor = highlighted
                clefBtnToggled1 = true
            }
            
            if i == 2 && usrInf.prefStave == "bass" || i == 2 && usrInf.prefStave == "grand" {
                button.backgroundColor = highlighted
                clefBtnToggled2 = true
            }
            
            buttons.append(button)
            buttonLayer.addSubview(buttons[buttons.count-1])
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func show(){
        toggled = true
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.frame.origin.y = sS.width*0.03
        })
    }
    func hide(){
        toggled = false
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.frame.origin.y = 0 - (sS.height*0.18 + sS.width*0.03)
        })
    }
    
    
}
