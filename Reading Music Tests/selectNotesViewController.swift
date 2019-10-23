//
//  selectNotesViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 29/09/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit


class selectNotesViewController: UIViewController {

    var scrollView : UIScrollView!
    var stave : StaveView!
    var notesToAdd = [Note2]()
    var gapSize : CGFloat!
    var notesOnStave = [Note2]()
    var bg : UIImageView!
    var selectedNotes = [String]()
    var titleLabel1 = UILabel()
    var titleLabel2 = UILabel()
    var sS = CGSize()
    var playBtn = PlayButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sS = UIScreen.main.bounds.size
        bg = UIImageView(frame: CGRect(x: 0, y: 0, width: sS.width, height: sS.height))
        bg.image = UIImage(named: "noteSelectBG")
        view.addSubview(bg)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 20, width: sS.width, height: sS.height - 20))
        view.addSubview(scrollView)
        stave = StaveView(spaceToFill: scrollView.frame, staveType: "treble", noteCount: trebleNotes.count, spacing: "compact")
        scrollView.addSubview(stave)
        scrollView.contentSize = CGSize(width: stave.frame.width, height: scrollView.frame.height)
        
        // get all the notes to show on stave and add them into an array
        getNotes(staveType: "treble")
        
        addNotesToStave()
        
        playBtn = PlayButton(frame: CGRect(x: sS.width*0.87, y: sS.height*0.83, width: sS.height*0.14, height: sS.height*0.14))
        playBtn.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
        
        view.addSubview(playBtn)
        
    }
    
    @objc func playAction(_ sender:UIButton){
        freeplayGame = gameStruct(start: true, notes: selectedNotes)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
        nextViewController.modalPresentationStyle = .fullScreen
        print("selectedNotes = \(selectedNotes)")
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func getNotes(staveType: String){
        if staveType == "treble" {
            for (i, note) in noteList.enumerated() {
                var newNote = Note2(pos: i, stave: staveType, note: trebleNotes[note]!.noteName, gapSize: stave.gapSize, noteGap: stave.noteGap, stavePosition: trebleNotes[note]!.stavePosition, lineWidth: stave.lineWidth, topLine: stave.staveLineArray[0].lineY)
                notesToAdd.append(newNote)
                
                let tap = selectNoteTap(target: self, action: #selector(self.handleTapFrom(recognizer:)))
                tap.num = i
                newNote.addGestureRecognizer(tap)
            }
        } else {
            for (i, note) in bassNotes.enumerated() {
                
            }
        }
        
        print(notesToAdd)
    }
    
    @objc func handleTapFrom(recognizer : selectNoteTap)
    {

        if notesOnStave[recognizer.num].selected {
            notesOnStave[recognizer.num].selected = false
            notesOnStave[recognizer.num].noteImage.tintColor = UIColor.black
            notesOnStave[recognizer.num].animation = "pop"
            notesOnStave[recognizer.num].animate()
            for line in notesOnStave[recognizer.num].ledgerLines {
                line.backgroundColor = UIColor.black
            }
        } else {
            notesOnStave[recognizer.num].selected = true
            notesOnStave[recognizer.num].noteImage.tintColor = UIColor.white
            notesOnStave[recognizer.num].animation = "pop"
            notesOnStave[recognizer.num].animate()
            for line in notesOnStave[recognizer.num].ledgerLines {
                line.backgroundColor = UIColor.white
            }
        }
        
        checkSelected()
        
    }
    
    
    func addNotesToStave(){
        var i = 0
        for note in notesToAdd {
            notesOnStave.append(note)
            scrollView.addSubview(notesOnStave[notesOnStave.count-1])
            i += 1
        }
    }
    
    /** Function to cycle through the notes and check which are selected **/
    func checkSelected() {
        selectedNotes = [String]()
        for note in notesOnStave {
            if note.selected {
                selectedNotes.append(note.note)
            }
        }
        print(selectedNotes)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showTitle()
    }
    
    func showTitle(){
        
        titleLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: stave.gapSize * 4, height: stave.gapSize))
        titleLabel1.textAlignment = .center
        titleLabel1.textColor = UIColor.white
        titleLabel1.font = UIFont(name: "Futura-Bold", size: (stave.gapSize * 0.9))
        titleLabel1.text = "SELECT"
        titleLabel1.frame.origin.y = stave.staveLineArray[1].lineY
        titleLabel1.center.x = sS.width / 2
        titleLabel1.alpha = 0
        scrollView.addSubview(titleLabel1)
        
        UIView.animate(withDuration: 1, delay:1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.titleLabel1.alpha = 1
        }, completion: { finished in
            
        })
        
        titleLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: stave.gapSize * 4, height: stave.gapSize))
        titleLabel2.textAlignment = .center
        titleLabel2.textColor = UIColor.white
        titleLabel2.font = UIFont(name: "Futura-Bold", size: (stave.gapSize * 0.9))
        titleLabel2.text = "NOTES"
        titleLabel2.frame.origin.y = stave.staveLineArray[2].lineY
        titleLabel2.center.x = sS.width / 2
        titleLabel2.alpha = 0
        scrollView.addSubview(titleLabel2)
        
        UIView.animate(withDuration: 1, delay:1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.titleLabel2.alpha = 1
        }, completion: { finished in
            UIView.animate(withDuration: 1, delay:2, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.titleLabel1.alpha = 0
                self.titleLabel2.alpha = 0
            })
        })
        
        
        
    }

}

class selectNoteTap: UITapGestureRecognizer {
    var num : Int!
}

class Note2 : SpringView {
    
    var noteX : CGFloat!
    var nS : CGSize!
    var note : String!
    var stave : String!
    var noteSpacing : CGFloat!
    var sfp : CGFloat!
    var gapSize : CGFloat!
    var ledgerLines = [UIView]()
    var noteYcenter : CGFloat!
    var noteXcenter : CGFloat!
    var lineWidth : CGFloat!
    var holder : UIView!
    let noteImage = UIImageView()
    var pos : Int!
    var firstStaveStep : CGFloat!
    var selected = false
    
    init(pos: Int, stave: String, note: String, gapSize: CGFloat, noteGap: CGFloat, stavePosition: Int, lineWidth: CGFloat, topLine: CGFloat) {
        let noteHeight = gapSize * 6.25
        /** Each step on the stave **/
        let staveSteps = gapSize / 2
        let noteSize = CGSize(width: (noteHeight / 932) * 189, height: noteHeight)
        /** sfp is the gap at the beginning of the stave **/
        sfp = noteGap * 2
    
        self.firstStaveStep = topLine - (staveSteps * 4)
        self.lineWidth = lineWidth
        self.pos = pos
        self.gapSize = gapSize
        
        super.init(frame: CGRect(x: 0, y: 0, width: noteSize.width, height: noteSize.height))
        
        self.nS = noteSize
        self.note = note
        self.stave = stave
        backgroundColor = UIColor.clear
        
        
        var loadedNote : noteStruct!
        
        if stave == "treble" {
            loadedNote = trebleNotes[note]
        } else {
            loadedNote = bassNotes[note]
        }
        
        addNoteImage(note: loadedNote)
        
        // set the center point of note
        self.center = CGPoint(x: sfp + (CGFloat(pos) * noteGap), y: firstStaveStep + (CGFloat(stavePosition) * staveSteps))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    func addNoteImage(note: noteStruct){
        
        
        let imageSrc = UIImage(named: "note")
        let tintedImage = imageSrc?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        noteImage.image = tintedImage
        noteImage.tintColor = UIColor.black
        noteImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(noteImage)
        if stave == "treble" {
            if (note.rotated) {
                noteImage.transform = noteImage.transform.rotated(by: CGFloat(180 * Double.pi / 180))
            }
            addLedgerLines(note: note)
        }
        if stave == "bass" {
            if (note.rotated) {
                noteImage.transform = noteImage.transform.rotated(by: CGFloat(180 * Double.pi / 180))
            }
            //addLedgerLines(count: (bassNotes[note]?.ledgers)!, offset: (bassNotes[note]?.ledgerOffset)!)
        }
    }
    
    func addLedgerLines(note: noteStruct){
        var offsetVal:CGFloat = 0.0
        if !note.ledgerOffset {
            offsetVal = gapSize * 0.5
        }
        
        print(" --- ")
        
        print("adding ledger lines for \(note.noteName). note.ledgers = \(note.ledgers)")
        
        var i = 0
        while i < note.ledgers {
            print("i = \(i), note.ledgers = \(note.ledgers)")
            var lineY:CGFloat = 0.0
            if note.rotated {
                lineY = self.center.y + offsetVal + (gapSize * CGFloat(i))
            } else {
                lineY = self.center.y - offsetVal - (gapSize * CGFloat(i))
            }
            
            
            ledgerLines.append(LedgerLines(lineY: lineY, lineX: self.center.x, ledgerWidth: gapSize*2, staveScale: gapSize, lineWidth: lineWidth))
            self.addSubview(ledgerLines[ledgerLines.count-1])
            i+=1
        }
        
        
        print(" --- ")
        
    }
    
}


class PlayButton: UIButton {
    
    var image : UIImageView!
    
    override func draw(_ rect: CGRect) {
        image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        image.image = UIImage(named: "playBtn")
        self.addSubview(image)
    }

}
