//
//  mainMenuButtons.swift
//  Reading Music Tests
//
//  Created by John Mckay on 16/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit
@IBDesignable

class mainMenuButtons: UIButton {
    override func draw(_ rect: CGRect) {
        let buttonWidth = self.frame.width
        let buttonHeight = self.frame.height
        
        let color1 = hexStringToUIColor(hex: "#e0dfd5")
        let color2 = hexStringToUIColor(hex: "#ef6461")
        let color3 = hexStringToUIColor(hex: "#e4b363")
        let color4 = hexStringToUIColor(hex: "#313638")
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: buttonHeight*0.90))
        path.addLine(to: CGPoint(x: 0, y: buttonHeight))
        path.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight))
        path.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.75))
        path.close()
        color4.setFill()
        path.fill()
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: buttonHeight*0.80))
        path2.addLine(to: CGPoint(x: 0, y: buttonHeight*0.90))
        path2.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.75))
        path2.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.50))
        path2.close()
        color3.setFill()
        path2.fill()
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: 0, y: buttonHeight*0.70))
        path3.addLine(to: CGPoint(x: 0, y: buttonHeight*0.80))
        path3.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.50))
        path3.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.25))
        path3.close()
        color2.setFill()
        path3.fill()
        let path4 = UIBezierPath()
        path4.move(to: CGPoint(x: 0, y: buttonHeight*0.68))
        path4.addLine(to: CGPoint(x: 0, y: buttonHeight*0.70))
        path4.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.25))
        path4.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.22))
        path4.close()
        color1.setFill()
        path4.fill()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
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
}
