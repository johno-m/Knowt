//
//  notesGameButton.swift
//  Reading Music Tests
//
//  Created by John Mckay on 18/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class notesGameButton: UIButton {

    override func draw(_ rect: CGRect) {
        let buttonWidth = self.frame.width
        let buttonHeight = self.frame.height
        
        let color1 = hexStringToUIColor(hex: "#e0dfd5")
        let color2 = hexStringToUIColor(hex: "#ef6461")
        let color3 = hexStringToUIColor(hex: "#e4b363")
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: buttonHeight))
        path.addLine(to: CGPoint(x: buttonWidth*0.36, y: buttonHeight))
        path.addLine(to: CGPoint(x: buttonWidth*0.304, y: buttonHeight*0.064)) // top right
        path.close()
        color1.setFill()
        path.fill()
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: buttonWidth*0.304, y: buttonHeight*0.064))
        path2.addLine(to: CGPoint(x: buttonWidth*0.36, y: buttonHeight))
        path2.addLine(to: CGPoint(x: buttonWidth*0.64, y: buttonHeight))
        path2.addLine(to: CGPoint(x: buttonWidth*0.691, y: buttonHeight*0.146))
        path2.close()
        color2.setFill()
        path2.fill()
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: buttonWidth*0.691, y: buttonHeight*0.146))
        path3.addLine(to: CGPoint(x: buttonWidth*0.64, y: buttonHeight))
        path3.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight    ))
        path3.addLine(to: CGPoint(x: buttonWidth, y: buttonHeight*0.21))
        path3.close()
        color3.setFill()
        path3.fill()
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
