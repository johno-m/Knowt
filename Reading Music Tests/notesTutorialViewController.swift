//
//  noteTutorialViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 28/07/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

// Notes Intro Tutorial Screen

import UIKit

class notesTutorialViewController: UIViewController, UIScrollViewDelegate {

    var backBtn : BackBtn!
    @IBOutlet weak var bgView: GradientView!
    var activePage = 0
    @IBOutlet weak var tutorialScroll: UIScrollView!
    @IBOutlet weak var tutorialView: UIView!
    var totalHeight:CGFloat = 0
    var tutImageArray : [TutorialImage]!
    var scrollArtboard : UIImageView!
    var notes = [Note2]()
    var nextBtn : NextBtn!
    var testStave : StaveView!
    
    var sS = CGSize()
    var imageList:[[UIImage]] = [
        [UIImage(named: "sT_title")!],
        [UIImage(named: "sT_staveInfo_step1")!, UIImage(named: "sT_staveInfo_step2")!, UIImage(named: "sT_staveInfo_step3")!, UIImage(named: "sT_staveInfo_step4")!, UIImage(named: "sT_staveInfo_step5")!],
        [UIImage(named: "sT_stave1")!],
        [UIImage(named: "sT_noteInfo_step1")!, UIImage(named: "sT_noteInfo_step2")!, UIImage(named: "sT_noteInfo_step3")!, UIImage(named: "sT_noteInfo_step4")!, UIImage(named: "sT_noteInfo_step5")!],
        [UIImage(named: "sT_sigInfo_step1")!, UIImage(named: "sT_sigInfo_step2")!, UIImage(named: "sT_sigInfo_step3")!, UIImage(named: "sT_sigInfo_step4")!, UIImage(named: "sT_sigInfo_step5")!],
        [UIImage(named: "sT_clefInfo_step1")!, UIImage(named: "sT_clefInfo_step2")!, UIImage(named: "sT_clefInfo_step3")!, UIImage(named: "sT_clefInfo_step4")!, UIImage(named: "sT_clefInfo_step5")!],
        [UIImage(named: "sT_goOnStave_step1")!, UIImage(named: "sT_goOnStave_step2")!, UIImage(named: "sT_goOnStave_step3")!, UIImage(named: "sT_goOnStave_step4")!, UIImage(named: "sT_goOnStave_step5")!, UIImage(named: "sT_goOnStave_step6")!],
        [UIImage(named: "sT_finalInfo")!]
    ]

    
    var images = [String : TutorialMultiImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sS = UIScreen.main.bounds.size
        
        
        loadUserInf()
        
        totalHeight = sS.height*5
        var h = sS.height
        var w = (sS.height/3)*4
        tutorialView.clipsToBounds = true
        
        scrollArtboard = UIImageView(image: UIImage(named: "artboard"))
        scrollArtboard.frame = CGRect(x: 0, y: 0, width: w, height: totalHeight)
        tutorialScroll.addSubview(scrollArtboard)
        
        tutorialScroll.contentSize = CGSize(width: w, height: totalHeight)
        tutorialScroll.alwaysBounceHorizontal = false
        tutorialScroll.alwaysBounceVertical = false
        tutorialScroll.delegate = self
        backBtn = BackBtn(color: UIColor.white)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        
        bgView.startColor = UIColor(red:0.43, green:0.84, blue:0.93, alpha:1.0)
        bgView.endColor = UIColor(red:0.13, green:0.58, blue:0.69, alpha:1.0)
        
        images["title"] = TutorialMultiImage(imgList: imageList[0], centerPoint: CGPoint(x: w*0.5, y: h*0.45), box: CGSize(width: w*0.57, height: totalHeight*0.08), style: "fadeInDrop")
        images["ThisIsAStave"] = TutorialMultiImage(imgList: imageList[1], centerPoint: CGPoint(x: w*0.755, y: totalHeight*0.255), box: CGSize(width: w*0.33, height: totalHeight*0.09), style: "fadeIn")
        images["Stave1"] = TutorialMultiImage(imgList: imageList[2], centerPoint: CGPoint(x: w*0.325, y: totalHeight*0.265), box: CGSize(width: w*0.65, height: totalHeight*0.07), style: "fadeInRight")
        images["noteInfo"] = TutorialMultiImage(imgList: imageList[3], centerPoint: CGPoint(x: w*0.67, y: totalHeight*0.365), box: CGSize(width: w*0.46, height: totalHeight*0.0402), style: "fadeIn")
        images["sigInfo"] = TutorialMultiImage(imgList: imageList[4], centerPoint: CGPoint(x: w*0.37, y: totalHeight*0.46), box: CGSize(width: w*0.48, height: totalHeight*0.06), style: "fadeIn")
        images["clefInfo"] = TutorialMultiImage(imgList: imageList[5], centerPoint: CGPoint(x: w*0.545, y: totalHeight*0.545), box: CGSize(width: w*0.45, height: totalHeight*0.0415), style: "fadeIn")
        images["onTheStave"] = TutorialMultiImage(imgList: imageList[6], centerPoint: CGPoint(x: w*0.53, y: totalHeight*0.625), box: CGSize(width: w*0.52, height: totalHeight*0.07), style: "fadeIn")
        images["finalInfo"] = TutorialMultiImage(imgList: imageList[7], centerPoint: CGPoint(x: w*0.55, y: totalHeight*0.7035), box: CGSize(width: w*0.66, height: totalHeight*0.12), style: "fadeIn")
        
        var whiteBand = UIView(frame: CGRect(x: 0, y: totalHeight*0.22, width: w, height: totalHeight*0.09))
        whiteBand.backgroundColor = UIColor.white
        
        tutorialScroll.addSubview(whiteBand)
        
        for (i, item) in images.enumerated() {
            tutorialScroll.addSubview(item.value)
            
        }
        
        images["title"]!.show()
        
        testStave = StaveView(spaceToFill: CGRect(x: w*0.08, y: totalHeight*0.617, width: w*0.84, height: totalHeight*0.187), staveType: "treble", noteCount: 3, spacing: "compact", showClef: true, timeSig: true, fixedWidth: true)
        notes.append(Note2(pos: 0, stave: "treble", note: "G4", gapSize: testStave.gapSize, noteGap: testStave.gapSize*3, stavePosition: trebleNotes["G4"]!.stavePosition, lineWidth: testStave.lineWidth, topLine: testStave.staveLineArray[0].lineY, stp: testStave.gapSize*7))
        notes.append(Note2(pos: 1, stave: "treble", note: "B4", gapSize: testStave.gapSize, noteGap: testStave.gapSize*3, stavePosition: trebleNotes["B4"]!.stavePosition, lineWidth: testStave.lineWidth, topLine: testStave.staveLineArray[0].lineY, stp: testStave.gapSize*7))
        notes.append(Note2(pos: 2, stave: "treble", note: "D5", gapSize: testStave.gapSize, noteGap: testStave.gapSize*3, stavePosition: trebleNotes["D5"]!.stavePosition, lineWidth: testStave.lineWidth, topLine: testStave.staveLineArray[0].lineY, stp: testStave.gapSize*7))
        for note in notes {
            testStave.addSubview(note)
            note.alpha = 0
        }
        testStave.clef.alpha = 0
        testStave.timeSig.alpha = 0
        tutorialScroll.addSubview(testStave)
        
        nextBtn = NextBtn(color: UIColor.white)
        view.addSubview(nextBtn)
        nextBtn.alpha = 0
        
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        
    }
    
    @objc func nextBtnPressed(){
        
        usrInf.tutsComplete["stave"] = true
        saveUserInf()
        if notesToLearn().count < 1 {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        } else {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorial2ViewController") as! notesTutorial2ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated:true, completion:nil)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let complete = usrInf.tutsComplete["stave"] {
            if complete {
                nextBtnPressed()
            }
        }
    }
    
    func notesToLearn() -> [String] {
        var i = 0
        var allNotesInGame = [String]()
        let instrumentNoteLevels = noteLevelList[usrInf.instrument]
        var notesInTutorial = [String]()
        let ceil = usrInf.treblelevel+1
        while i < ceil {
            for note in instrumentNoteLevels![i] {
                allNotesInGame.append(note)
            }
            i += 1
        }
        
        for note in allNotesInGame {
            print(note)
            if (trebleNotes[note]?.score)! < 1 {
                notesInTutorial.append(note)
            }
        }
        
        print("Notes that need to be learnt: \(notesInTutorial)")
        return notesInTutorial
    }
    
    func checkPosition(pos: CGFloat){
        print("pos: \(pos)")
        if pos > 0.1457 && images["ThisIsAStave"]!.shown == false {
            images["ThisIsAStave"]!.show()
        }
        if pos > 0.1450 && images["Stave1"]!.shown == false {
            images["Stave1"]!.show()
            
        }
        if pos > 0.2713688946015424 && images["noteInfo"]!.shown == false {
            images["noteInfo"]!.show()
        }
        
        if pos > 0.38769280205655526 && images["sigInfo"]!.shown == false {
            images["sigInfo"]!.show()
        }
        
        if pos > 0.4943766066838046 && images["clefInfo"]!.shown == false {
            images["clefInfo"]!.show()
        }
        
        if pos > 0.5711760925449871 && images["onTheStave"]!.shown == false {
            images["onTheStave"]!.show()
        }
        
        if pos > 0.7005141388174807 && self.testStave.clef.alpha == 0 {
            UIView.animate(withDuration: 1.2, delay:0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.testStave.clef.alpha = 1
            })
            UIView.animate(withDuration: 1.2, delay:1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.testStave.timeSig.alpha = 1
            })
            UIView.animate(withDuration: 1.2, delay:1.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.notes[0].alpha = 1
            })
            
            UIView.animate(withDuration: 1.2, delay:1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.notes[1].alpha = 1
            })
            
            UIView.animate(withDuration: 1.2, delay:1.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.notes[02].alpha = 1
            }, completion: { finished in
                self.images["finalInfo"]!.show()
            })
        }
        
        
        if pos > 0.9985539845758354 && nextBtn!.alpha == 0 {
            UIView.animate(withDuration: 1.2, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.nextBtn!.alpha = 1
            })
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var maximumVerticalOffset = scrollView.contentSize.height - scrollView.frame.height;
        var currentVerticalOffset = scrollView.contentOffset.y;
        
        // percentages
        var percentageVerticalOffset = currentVerticalOffset / maximumVerticalOffset;
        checkPosition(pos: percentageVerticalOffset)
        let startColor1 = UIColor(red:0.27, green:0.80, blue:0.93, alpha:1.0)
        let startColor2 = hex(hex: "3ce296")
        let endColor1 = UIColor(red:0.13, green:0.58, blue:0.69, alpha:1.0)
        let endColor2 = hex(hex: "38ce89")

        bgView.startColor = startColor1.interpolateRGBColorTo(startColor2, fraction:percentageVerticalOffset)!
        bgView.endColor = endColor1.interpolateRGBColorTo(endColor2, fraction:percentageVerticalOffset)!

    }
    
    @objc func backBtnPressed(_ sender:UIButton){
        let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    }
    
}

class TutorialImage: UIImageView {
    
    var fadeIn : CGFloat!
    var fadeOut : CGFloat!
    var maxAlpha : CGFloat!
    var step : Int!
    
    init(box: CGRect, step: Int, fadeIn: CGFloat, fadeOut: CGFloat, imageName: String, maxAlpha: CGFloat){
        super.init(frame: box)
        self.fadeIn = fadeIn
        self.fadeOut = fadeOut
        self.maxAlpha = maxAlpha
        self.step = step
        self.image = UIImage(named: imageName)
        self.alpha = 0
    }
    
    func show(){
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.alpha = self.maxAlpha
        })
    }
    
    func hide(){
        UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.alpha = 0
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { return CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}


class tutorialProgressBar : UIView {
    
    init(box: CGRect, step: Int, fadeIn: CGFloat, fadeOut: CGFloat, imageName: String, maxAlpha: CGFloat){
        super.init(frame: box)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
