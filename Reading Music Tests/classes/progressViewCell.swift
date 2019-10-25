//
//  progressViewCell.swift
//  Reading Music Tests
//
//  Created by John Mckay on 23/10/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import UIKit

class ProgressViewCell: UITableViewCell {
    
    @IBOutlet weak var noteTypeLabel: UILabel!
    @IBOutlet weak var noteNameLabel: UILabel!
    @IBOutlet weak var notePreviewView: NotePreviewView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var correctCountLbl: UILabel!
    @IBOutlet weak var incorrectCountLbl: UILabel!
    @IBOutlet weak var noteStreakLbl: UILabel!
    @IBOutlet weak var avgTimeLbl: UILabel!
    @IBOutlet weak var totalSeenLbl: UILabel!
    @IBOutlet weak var isMasteredLbl: UILabel!
    @IBOutlet weak var progBar: UIProgressView!
    @IBOutlet weak var progTotalScoreLbl: UILabel!
    
    func buildCell(i: Int, note: String){
        
        let targetNote = trebleNotes[note]
        detailsView.layer.cornerRadius = 10
        noteNameLabel.text = "\(targetNote!.humanNoteName)"
        let descText = targetNote?.descNoteName.split{$0 == " "}.map(String.init)
        noteTypeLabel.text = "\(descText![0])"
        scoreLbl.text = "\(targetNote!.score)"
        correctCountLbl.text = "\(targetNote!.correctCount)"
        incorrectCountLbl.text = "\(targetNote!.incorrectCount)"
        if targetNote!.score > promotionThreshold {
            isMasteredLbl.text = "YES"
        } else {
            isMasteredLbl.text = "NO"
        }
        
        progTotalScoreLbl.text = "\(promotionThreshold)"
        
        let score:Float = Float(targetNote!.score)
        let target:Float = Float(promotionThreshold)
        let progressPercentage = score / target
        print("progressPercentage = \(progressPercentage)")
        
        
        progBar.setProgress(progressPercentage, animated: true)
        
        noteStreakLbl.text = "\(targetNote!.correctRunningCount - targetNote!.incorrectRunningCount)"
        
        let totalSeen = targetNote!.correctCount + targetNote!.incorrectCount
        var totalTime:Double = 0
        if targetNote!.responseTimes.count > 0 {
            for time in targetNote!.responseTimes {
                totalTime += time
            }
        }
        
        totalSeenLbl.text = "\(totalSeen)"
        avgTimeLbl.text = "\(totalTime)s"
        // / Double(totalSeen)
        
        notePreviewView.buildView(note: note, stave: usrInf.prefStave)
        
    }
}


class NotePreviewView : UIView {

    var staveLineArray = [StaveLine2]()
    
    var singleStaveY:[CGFloat] = [
        0.28,
        0.36,
        0.44,
        0.52,
        0.60
    ]
    
    var newNote : Note2!
    
    var lineWidth : CGFloat!
    var newStave: StaveView!
    
    func buildView(note: String, stave: String){
        lineWidth = 180 * 0.016
        for (i, point) in singleStaveY.enumerated() {
            let staveLine = StaveLine2(lineY: (180 * point), lineWidth: lineWidth, length: 110)
            staveLine.center.x = 70
            staveLine.alpha = 0.6
            staveLineArray.append(staveLine)
            self.addSubview(staveLineArray[i])
        }
        var noteGap = staveLineArray[1].lineY - staveLineArray[0].lineY
        
        newNote = Note2(pos: 0, stave: usrInf.prefStave, note: note, gapSize: noteGap, noteGap: 35, stavePosition: trebleNotes[note]!.stavePosition, lineWidth: lineWidth, topLine: staveLineArray[0].lineY)
        self.addSubview(newNote)
        newNote.noteImage.tintColor = UIColor.white
    }
    
}
