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
    
    init(spaceToFill: CGRect, staveType: String, noteCount: Int, spacing: String, showClef: Bool){
        
        self.gapSize = spaceToFill.height * 0.08
        if spacing == "compact" {
            self.noteGap = self.gapSize * 3
        } else {
            self.noteGap = self.gapSize * 7
        }
        
        super.init(frame: CGRect(x: 0, y: 0, width: self.noteGap * CGFloat(noteCount + 3),  height: spaceToFill.height))
        
        self.lineWidth = spaceToFill.height * 0.008
        for (i, point) in singleStaveY.enumerated() {
            let staveLine = StaveLine2(lineY: (spaceToFill.height * point), lineWidth: lineWidth, length: self.frame.width)
            staveLineArray.append(staveLine)
            self.addSubview(staveLineArray[i])
        }
        
        if showClef { addClef(staveType: staveType) }
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
    
    //var lineY = [CGFloat]!
    /*
    
    
    func drawStaves(){
        var j = 0
        staveLines1 = [StaveLine]()
        staveLines2 = [StaveLine]()
        
        func drawTrebleStave(targetStave: UIView){
            j = 0
            for i in 4...8 {
                
                staveLines1.append(StaveLine(lineY: splitSize * CGFloat(i-eav), lineWidth: lineWidth, sS: sS))
                targetStave.addSubview(staveLines1[j])
                
                j += 1
            }
        }
        

        
    }
 */
    /*
    func scaleStavesToFit(staveWidth: CGFloat, staveType: String){
        if staveType == "grand" {
            topStave.frame.size.width = staveWidth
            bottomStave.frame.size.width = staveWidth
        } else {
            topStave.frame.size.width = staveWidth
        }
        
        for staveLine in staveLines1 {
            staveLine.frame.size.width = staveWidth
        }
        for staveLine in staveLines2 {
            staveLine.frame.size.width = staveWidth
        }
    }
    
    func addEndCap(staveWidth: CGFloat){
        
        if self.staveType == "grand" {
            
            //this adds endcap
            
            let endCap2 = UIView()
            let endCapWidth = self.staveScale * 0.3
            let endCapHeight = self.staveScale * 4
            endCap2.frame = CGRect(x: staveWidth - endCapWidth, y: 0, width: endCapWidth, height: endCapHeight)
            endCap2.backgroundColor = UIColor.black
            endCap2.center.y = self.staveScale * CGFloat(5 - eav)
            bottomStave.addSubview(endCap2)
            
        }
        
        let endCap = UIView()
        let endCapWidth = self.staveScale * 0.3
        let endCapHeight = self.staveScale * 4
        endCap.frame = CGRect(x: staveWidth - endCapWidth, y: 0, width: endCapWidth, height: endCapHeight)
        endCap.backgroundColor = UIColor.black
        endCap.center.y = self.staveScale * CGFloat(6 - eav)
        topStave.addSubview(endCap)
        
        if self.staveType == "bass" {
            endCap.center.y = self.staveScale * CGFloat(5 - eav)
        }
        
    }
    
    
    func addGrandBrace(){
        let braceLine = UIView()
        let braceCurl = UIImageView(image: UIImage(named: "braceCurl"))
        let top = topStave.convert(staveLines1[0].frame, to: self)
        let bottom = bottomStave.convert(staveLines2[4].frame, to: self)
        let lineHeight = bottom.origin.y - top.origin.y
        
        braceLine.frame = CGRect(x: top.origin.x, y: top.origin.y, width: lineWidth, height: lineHeight)
        braceLine.backgroundColor = UIColor.black
        self.addSubview(braceLine)
        
        //brace curl - 164 × 1274
        let braceCurlX = braceLine.frame.origin.x - ((braceLine.frame.height/1274)*164)
        braceCurl.frame = CGRect(x: braceCurlX, y: braceLine.frame.origin.y, width: (braceLine.frame.height/1274)*164, height: braceLine.frame.height)
        self.addSubview(braceCurl)
    }
    */
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
