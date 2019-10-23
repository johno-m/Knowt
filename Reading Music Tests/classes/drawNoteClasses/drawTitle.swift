//
//  drawTitle.swift
//  Reading Music Tests
//
//  Created by John Mckay on 11/02/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class DrawTitleScreen : UIView {
    
    var tL1 : UILabel!
    var tL2 : UILabel!
    var tL3 : UILabel!
    var sS : CGSize!
    var titleShape : ShapeToDraw!
    
    init(sS: CGSize){
        let frame = CGRect(x: 0, y: 0, width: sS.width, height: sS.height)
        super.init(frame: frame)
        self.sS = sS
        tL1 = makeLabel(frame: CGRect(x: sS.width * 0.23, y: 0, width: sS.width * 0.2, height: sS.height * 0.125), text: "How to", num: 1, of: 3)
        tL2 = makeLabel(frame: CGRect(x: sS.width * 0.23, y: 0, width: sS.width * 0.2, height: sS.height * 0.125), text: "Draw a", num: 2, of: 3)
        tL3 = makeLabel(frame: CGRect(x: sS.width * 0.23, y: 0, width: sS.width * 0.2, height: sS.height * 0.125), text: "Note", num: 3, of: 3)
        self.addSubview(tL1)
        self.addSubview(tL2)
        self.addSubview(tL3)
        UIView.animate(withDuration: 1, delay:1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.tL1.alpha = 1
            self.tL2.alpha = 1
            self.tL3.alpha = 1
        }, completion: { finished in
            
        })
        
        print("sS = \(sS)")
        titleShape = ShapeToDraw(sS: sS, cP: CGPoint(x: 0.65, y: 0.62), orientation: "up", shapeName: "note", rRatio: 0.10, delay: 1, dashed: true, withGuide: false, guideShape: "nil", shown: true)
        self.addSubview(titleShape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeLabel(frame: CGRect, text: String, num: CGFloat, of: CGFloat) -> UILabel {
        let originY = (sS.height * 0.5) - ((frame.height * of) * 0.5)
        let thisY = originY + (frame.height * (num - 1))
        let label = UILabel(frame: CGRect(x: frame.origin.x, y: thisY, width: frame.width, height: frame.height))
        
        label.text = "\(text)"
        label.textColor = UIColor.white
        label.font = UIFont(name: "AmaticSC-Regular", size: 100)
        label.alpha = 0
        return label
    }
    
    
    
    func remove(){
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.removeFromSuperview()
        })
        
    }
    
}
