//
//  stave.swift
//  Reading Music Tests
//
//  Created by John Mckay on 27/01/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class Stave : UIView {
    var staveScale : CGFloat!
    var staveType : String! // bass, treble, grand
    var staveLength : CGFloat! // 4, 8, 12
    var staveFrame : CGRect!
    var staveLines1 : [StaveLine]!
    var staveLines2 : [StaveLine]!
    var staveEnd : UIView!
    var topStave : UIView!
    var bottomStave : UIView!
    var splitSize : CGFloat!
    var lineWidth : CGFloat!
    var lineCount : CGFloat!
    var buttonLayer : UIView!
    let trebleClef = UIImageView()
    let bassClef = UIImageView()
    var timeSig2 = UIImageView()
    var timeSig1 = UIImageView()
    
    var sS : CGRect!
    
    var trebleClefOriginalPos : CGFloat!
    
    init(staveType: String, staveLength: CGFloat, lineWidth: CGFloat, lineCount: CGFloat, sS: CGRect){
        super.init(frame: CGRect(x: sS.height*0.02, y: sS.height*0.01, width: staveLength, height: sS.height*0.90))
        self.staveType = staveType
        self.staveLength = staveLength
        self.lineWidth = lineWidth
        self.lineCount = lineCount
        self.sS = sS
        updateFrame()
        drawStaves()
        
        if staveType == "grand" { addGrandBrace() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: sH*0.02, y: sH*0.01, width: 300, height: sH*0.90))
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
    
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
            
            
            let trebleClefHeight = (targetStave.frame.height / lineCount) * 7.4
            let trebleClefMid = (targetStave.frame.height / lineCount) * CGFloat(6 - (eav))
            trebleClef.image = UIImage(named: "trebleClef")
            trebleClef.frame = CGRect(x: targetStave.frame.height*0.06, y: 0, width: (trebleClefHeight / 1100) * 415, height: trebleClefHeight)
            trebleClef.center.y = trebleClefMid
            trebleClefOriginalPos = trebleClef.frame.origin.x
            targetStave.addSubview(trebleClef)
            let timeSigWidth = (trebleClef.frame.height / 1100) * 265
            timeSig1 = UIImageView(image: UIImage(named: "timesig"))
            timeSig1.frame = CGRect(x: (trebleClef.frame.origin.x + trebleClef.frame.width)*1.1, y: trebleClef.frame.origin.y, width: timeSigWidth, height: trebleClef.frame.height)
            targetStave.addSubview(timeSig1)
            
        }
        
        
        func drawBassStave(targetStave: UIView){
            j = 0
            for i in 3...7 {
                staveLines2.append(StaveLine(lineY: splitSize * CGFloat(i-eav), lineWidth: lineWidth, sS: sS))
                targetStave.addSubview(staveLines2[j])
                j += 1
            }
            
            let bassClefHeight = (targetStave.frame.height / lineCount) * 7.4
            
            let bassClefMid = (topStave.frame.height / lineCount) * CGFloat(5 - (eav))
            timeSig2 = UIImageView(image: UIImage(named: "timesig"))
            bassClef.image = UIImage(named: "bassClef")
            bassClef.frame = CGRect(x: targetStave.frame.height*0.06, y: 0, width: (bassClefHeight / 1100) * 415, height: bassClefHeight)
            let timeSigWidth = (bassClef.frame.height / 1100) * 265
            bassClef.center.y = bassClefMid
            targetStave.addSubview(bassClef)
            timeSig2.frame = CGRect(x: (bassClef.frame.origin.x + bassClef.frame.width)*1.1, y: bassClef.frame.origin.y, width: timeSigWidth, height: bassClef.frame.height)
            targetStave.addSubview(timeSig2)
            
        }
        
        
        
        if staveType == "grand" {
            
            topStave = UIView(frame: self.frame)
            bottomStave = UIView(frame: self.frame)
            
            topStave.frame.size.height = self.frame.height * 0.5
            bottomStave.frame.size.height = self.frame.height * 0.5
            
            bottomStave.frame.origin.y = bottomStave.frame.origin.y + (self.frame.height * 0.5)
            
            topStave.frame.origin.x = sS.width*1.1
            bottomStave.frame.origin.x = sS.width*1.1
            
            splitSize = topStave.frame.size.height / lineCount
            staveScale = splitSize
            
            self.addSubview(topStave)
            self.addSubview(bottomStave)
            
            //            //
            //            topStave.backgroundColor = UIColor.green
            //            bottomStave.backgroundColor = UIColor.red
            
            drawTrebleStave(targetStave: topStave)
            drawBassStave(targetStave: bottomStave)
            
        }
        
        if staveType != "grand" {
            topStave = UIView(frame: self.frame)
            
            topStave.frame.size.height = self.frame.height * 0.7
            topStave.frame.origin.y = self.frame.height * 0.1
            
            topStave.frame.origin.x = sS.width*1.1
            
            splitSize = topStave.frame.size.height / lineCount
            staveScale = splitSize
            
            self.addSubview(topStave)
            
            //
            if staveType == "treble" {
                drawTrebleStave(targetStave: topStave)
            } else {
                drawBassStave(targetStave: topStave)
            }
        }
        
    }
    
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
    
    func updateFrame(){
        //        self.frame = CGRect(x: 300, y: 0, width: 300, height: 300)
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
    
    
}

class StaveLine : UIView {
    
    var lineY : CGFloat!
    var lineWidth : CGFloat!
    
    init(lineY: CGFloat, lineWidth: CGFloat, sS: CGRect) {
        self.lineY = lineY
        super.init(frame: CGRect(x: 0, y: lineY, width: sS.width * 0.8, height: lineWidth))
        backgroundColor = UIColor.black
        self.center.y = lineY
        self.lineWidth = lineWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
    
}



class Note : SpringView {
    //625
    
    var noteX : CGFloat!
    var nS : CGSize!
    var note : String!
    var stave : String!
    var noteSpacing : CGFloat!
    var sfp : CGFloat!
    var staveScale : CGFloat!
    var ledgerLines = [UIView]()
    var noteYcenter : CGFloat!
    var noteXcenter : CGFloat!
    var lineWidth : CGFloat!
    var holder : UIView!
    let noteImage = UIImageView()
    var pos : Int!
    
    init(pos: Int, stave: String, note: String, staveScale: CGFloat, stavePosition: Int, lineWidth: CGFloat) {
        let noteHeight = staveScale * 6.25
        let staveSteps = staveScale / 2
        let noteSize = CGSize(width: (noteHeight / 932) * 189, height: noteHeight)
        let noteY = (staveSteps*CGFloat(stavePosition+4))-(noteHeight/2) // first 4 spaces are left clear - possible expansion of two more notes in future.
        sfp = staveScale * 9 // staveFrontPadding
        
        if eav > 0 {
            self.noteSpacing = staveScale * 7
        } else {
            self.noteSpacing = staveScale * 4
        }
        self.noteYcenter = noteSize.height * 0.5
        self.noteXcenter = noteSize.width * 0.5
        self.lineWidth = lineWidth
        self.pos = pos
        
        let noteX = ((CGFloat(pos) * noteSpacing)+sfp)-(noteSize.width * 0.5)
        
        super.init(frame: CGRect(x: noteX, y: noteY, width: noteSize.width, height: noteSize.height))
        self.nS = noteSize
        self.note = note
        self.stave = stave
        self.staveScale = staveScale
        backgroundColor = UIColor.clear
        
        addNoteImage(note: note)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    func addNoteImage(note: String){
        
        
        let imageSrc = UIImage(named: "note")
        let tintedImage = imageSrc?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        noteImage.image = tintedImage
        noteImage.tintColor = UIColor.black
        noteImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(noteImage)
        if stave == "treble" {
            if (trebleNotes[note]?.rotated)! {
                noteImage.transform = noteImage.transform.rotated(by: CGFloat(180 * Double.pi / 180))
            }
            addLedgerLines(count: (trebleNotes[note]?.ledgers)!, offset: (trebleNotes[note]?.ledgerOffset)!)
        }
        if stave == "bass" {
            if (bassNotes[note]?.rotated)! {
                noteImage.transform = noteImage.transform.rotated(by: CGFloat(180 * Double.pi / 180))
            }
            addLedgerLines(count: (bassNotes[note]?.ledgers)!, offset: (bassNotes[note]?.ledgerOffset)!)
        }
    }
    
    func addLedgerLines(count: Int, offset: Bool){
        var offsetVal:CGFloat = 0.0
        if !offset {
            offsetVal = staveScale * 0.5
        }
        var j = count-1
        if count < 4 && count > 0 {
            for i in 0...j {
                ledgerLines.append(LedgerLines(lineY: noteYcenter - offsetVal - (staveScale * CGFloat(i)), lineX: noteXcenter, ledgerWidth: staveScale*2, staveScale: staveScale, lineWidth: lineWidth))
                self.addSubview(ledgerLines[ledgerLines.count-1])
            }
        }
        j = count-4
        if count > 3 {
            for i in 0...j {
                ledgerLines.append(LedgerLines(lineY: noteYcenter + offsetVal + (staveScale * CGFloat(i)), lineX: noteXcenter, ledgerWidth: staveScale*2, staveScale: staveScale, lineWidth: lineWidth))
                self.addSubview(ledgerLines[ledgerLines.count-1])
            }
            
        }
    }
    
}

class BarLine : UIView {
    var lineY : CGFloat!
    
    init(lineY: CGFloat, lineX: CGFloat, barHeight: CGFloat, lineWidth: CGFloat) {
        self.lineY = lineY
        super.init(frame: CGRect(x: lineX, y: lineY, width: lineWidth, height: barHeight))
        backgroundColor = UIColor.black
        self.center.y = lineY
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
}

class LedgerLines : UIView {
    var lineY : CGFloat!
    var lineX : CGFloat!
    
    init(lineY: CGFloat, lineX: CGFloat, ledgerWidth: CGFloat, staveScale: CGFloat, lineWidth: CGFloat) {
        self.lineY = lineY
        super.init(frame: CGRect(x: lineX, y: lineY, width: ledgerWidth, height: lineWidth))
        backgroundColor = UIColor.black
        self.center.y = lineY
        self.center.x = lineX
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
}
