//
//  stave.swift
//  Reading Music Tests
//
//  Created by John Mckay on 27/01/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class StaveView : UIView {

    /** The array that holds the StaveLine UIViews **/
    var staveLineArray = [StaveLine2]()
    
    /** ImageView to hold the clef inside the StaveView **/
    var clef = UIImageView()
    
    /** Gap between lines in the stave **/
    var gapSize : CGFloat!
    
    /** Gap between notes on the stave **/
    var noteGap : CGFloat!
    
    var lineWidth : CGFloat!
    
    /** Percentage of the StaveView Height for the lines **/
    var singleStaveY:[CGFloat] = [
        0.28,
        0.36,
        0.44,
        0.52,
        0.60
    ]
    
    var startingPos:CGFloat = 0
    
    var timeSig : UIImageView!
    
    
    init(spaceToFill: CGRect, staveType: String, noteCount: Int, spacing: String, showClef: Bool, timeSig: Bool, fixedWidth: Bool? = false){
        
        self.gapSize = spaceToFill.height * 0.08
        if spacing == "compact" {
            self.noteGap = self.gapSize * 3
        } else {
            self.noteGap = self.gapSize * 7
        }
        
        startingPos = gapSize * CGFloat(6)
        
        var setWidth = self.noteGap * CGFloat(noteCount + 3)
        if fixedWidth! {
            setWidth = spaceToFill.width
        }
            
        
        super.init(frame: CGRect(x: spaceToFill.minX, y: spaceToFill.minY, width: setWidth,  height: spaceToFill.height))
        
        self.lineWidth = spaceToFill.height * 0.008
        for (i, point) in singleStaveY.enumerated() {
            let staveLine = StaveLine2(lineY: (spaceToFill.height * point), lineWidth: lineWidth, length: setWidth)
            staveLineArray.append(staveLine)
            self.addSubview(staveLineArray[i])
        }
        
        if showClef { addClef(staveType: staveType) }
        if timeSig {
            addTimeSig()
            startingPos += gapSize * 3
        }
    }
    
    func addTimeSig(){
        print("--- ADDING TIME SIG ---")
        let a:CGFloat = 260 / 580 //
        let b = CGFloat(gapSize*4) * a
        timeSig = UIImageView(frame: CGRect(x: 0, y: 0, width: b, height: gapSize*4))
        timeSig.image = UIImage(named: "timesig2")
        timeSig.center = CGPoint(x: gapSize*4, y: staveLineArray[2].lineY)
        self.addSubview(timeSig)
    }
    
    func addClef(staveType: String){
        
        let clefHeight = gapSize * 7.4
        let clefWidth = (clefHeight / 1100) * 415
        
        if staveType == "treble" {
            clef.image = UIImage(named: "trebleClef")
        } else {
            clef.image = UIImage(named: "bassClef")
        }
        
        clef.frame = CGRect(x: 0, y: 0, width: clefWidth, height: clefHeight)
        clef.center = CGPoint(x: gapSize*1.5, y: staveLineArray[2].lineY)
        self.addSubview(clef)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class StaveLine2 : UIView {
    
    var lineY : CGFloat!
    var lineWidth : CGFloat!
    
    init(lineY: CGFloat, lineWidth: CGFloat, length: CGFloat) {
        self.lineY = lineY
        super.init(frame: CGRect(x: 0, y: lineY, width: length, height: lineWidth))
        backgroundColor = UIColor.black
        self.center.y = lineY
        self.lineWidth = lineWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
    
}
