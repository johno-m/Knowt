//
//  drawNoteGameViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 23/11/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class drawNoteGameViewController: UIViewController {
    
    //    var gameWindow: DrawWindowGame!
    //    var tutorialWindow: TutorialWindow!
    var sS: CGSize!
    var intro: IntroView!
    var tutImage: TutImage!
    var tutLabel: TutLabel!
    var fingerIndicator: FingerIndicator!
    var userHasTouched = false
    var timer = Timer()
    var activeShape: ShapeToDraw! // what shape should be checked?
    var failedAttempts = 0
    var shapeToDraw : ShapeToDraw!
    var skipBtn : UIButton!
    var currentStep = 1
    var savedShape : UIView!
    /** Variable to store the copy of what the user has just drawn */
    var shapeToDrawRelic : UserDrawnRelic!
    
    var userDrawnShape : UserDrawnShape!
    
    var progBar : ProgressBar!
    
    func begin(){
        showTitleScreen()
        progBar = ProgressBar(sS: sS)
        view.addSubview(progBar)
        //        var TutorialWindow = DrawNoteTutorial(sS: sS)
        //        self.addSubview(TutorialWindow)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sS = UIScreen.main.bounds.size
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        begin()
    }
    
    func showTitleScreen(){
        let tutorialTitleScreen = DrawTitleScreen(sS: sS)
        view.addSubview(tutorialTitleScreen)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // change 2 to desired number of seconds
            tutorialTitleScreen.remove()
            self.showTutorial()
        }
    }
    
    func updateProgress(count: Int, complete: Bool, delay: TimeInterval){
        
        progBar.setActiveIcon(newActiveIcon: count, delay: delay)
        
        if complete {
            progBar.setCompleteIcon(count: count)
        }
    }
    
    func showTutorial(){
        if currentStep == 1 {
            progBar.fade()
            shapeToDraw = ShapeToDraw(sS: sS, cP: CGPoint(x: 0.5, y: 0.5), orientation: "up", shapeName: "wave", rRatio: 0.30, delay: 2, dashed: true, withGuide: false, guideShape: "nil", shown: true)
            activeShape = shapeToDraw
            view.addSubview(shapeToDraw)
            activateUserDrawing()
            tutLabel = TutLabel(sS: sS, delay: 2, text: "Trace the line", shouldShow: true, position: "top")
            view.addSubview(tutLabel)
            timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(showFingerIndicator), userInfo: nil, repeats: true)
            updateProgress(count: 0, complete: false, delay: 2)
        }
        if currentStep == 2 {
            shapeToDraw = ShapeToDraw(sS: sS, cP: CGPoint(x: 0.7, y: 0.65), orientation: "up", shapeName: "circle", rRatio: 0.15, delay: 2, dashed: true, withGuide: true, guideShape: "circle", shown: true, startHereInd: true)
            activeShape = shapeToDraw
            view.addSubview(shapeToDraw)
            activateUserDrawing()
            tutLabel = TutLabel(sS: sS, delay: 2, text: "draw a circle", shouldShow: true, position: "left")
            view.addSubview(tutLabel)
            timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(showFingerIndicator), userInfo: nil, repeats: true)
            updateProgress(count: 1, complete: true, delay: 0)
        }
        if currentStep == 3 {
            shapeToDraw = ShapeToDraw(sS: sS, cP: CGPoint(x: 0.7, y: 0.65), orientation: "up", shapeName: "stem", rRatio: 0.15, delay: 2, dashed: true, withGuide: false, guideShape: "nil", shown: true, startHereInd: true)
            activeShape = shapeToDraw
            view.addSubview(shapeToDraw)
            activateUserDrawing()
            tutLabel = TutLabel(sS: sS, delay: 2, text: "Now add the stem", shouldShow: true, position: "left")
            view.addSubview(tutLabel)
            timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(showFingerIndicator), userInfo: nil, repeats: true)
            updateProgress(count: 2, complete: true, delay: 0)
        }
        if currentStep == 4 {
            shapeToDraw = ShapeToDraw(sS: sS, cP: CGPoint(x: 0.7, y: 0.65), orientation: "up", shapeName: "note", rRatio: 0.15, delay: 2, dashed: true, withGuide: false, guideShape: "nil", shown: true, startHereInd: true)
            activeShape = shapeToDraw
            view.addSubview(shapeToDraw)
            activateUserDrawing()
            tutLabel = TutLabel(sS: sS, delay: 2, text: "Now draw a note", shouldShow: true, position: "right")
            view.addSubview(tutLabel)
            timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(showFingerIndicator), userInfo: nil, repeats: true)
            updateProgress(count: 3, complete: true, delay: 0)
        }
        if currentStep == 5 {
            progBar.setCompleteIcon(count: 4)
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        
    }
    
    @objc func showFingerIndicator() {
        if self.userHasTouched != true {
            self.fingerIndicator = FingerIndicator(sS: self.sS, cP: activeShape.noteStartPoint, path: activeShape.path)
            view.addSubview(self.fingerIndicator)
            self.fingerIndicator.move()
        } else {
            self.timer.invalidate()
        }
    }
    
    func activateUserDrawing(){
        userDrawnShape = UserDrawnShape(isActive: true, pointsList: activeShape.path.lookupTable, sS: sS)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(userDrawnShape)
        
        if userDrawnShape != nil && userDrawnShape.active {
            userDrawnShape.colorMe()
            shapeToDraw.hideGuide()
            shapeToDraw.hideStartHereInd()
            if userDrawnShape.userDrawnPath != nil {
                userDrawnShape.userDrawnPath.removeAllPoints()
                userDrawnShape.userPoints = [PointsToCover]()
            }
            
            let touch = touches.first!
            let location = touch.location(in: view)
            userDrawnShape.userPoints = [PointsToCover(loc: location, cov: false)]
            userDrawnShape.userDrawnPath.move(to: location)
            userHasTouched = true
            view.layer.addSublayer(userDrawnShape)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userDrawnShape != nil && userDrawnShape.active {
            let touch = touches.first!
            let location = touch.location(in: view)
            userDrawnShape.userDrawnPath.addLine(to: location)
            userDrawnShape.path = userDrawnShape.userDrawnPath.cgPath
            userDrawnShape.userPoints.append(PointsToCover(loc: location, cov: false))
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userDrawnShape != nil && userDrawnShape.active {
            check()
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userDrawnShape != nil && userDrawnShape.active {
            check()
        }
        
    }
    
    @objc func nextStep(){
        if currentStep == 1 {
            userDrawnShape.remove()
            
            shapeToDraw.remove()
            
        }
        if currentStep == 2 {
            shapeToDrawRelic = UserDrawnRelic(path: userDrawnShape!.path!)
            userDrawnShape.remove()
            
            view.layer.addSublayer(shapeToDrawRelic)
            shapeToDraw.remove()
        }
        if currentStep == 3 {
            userDrawnShape.remove()
            shapeToDrawRelic.remove()
            shapeToDraw.remove()
        }
        currentStep += 1
        showTutorial()
    }
    
    
    func check(){
        if userDrawnShape.userPoints.count > 10 {
            var fbFlair : DrawNoteFlair!
            if userDrawnShape.checkDrawing(debug: false).success {
                userDrawnShape.active = false
                tutLabel.remove()
                let a:Float = userDrawnShape.checkDrawing(debug: false).accuracy
                if a > Float(0.999) {
                    fbFlair = DrawNoteFlair(sS: sS, success: true, text: "PERFECT", path: userDrawnShape.userDrawnPath)
                } else if a > Float(0.99) {
                    fbFlair = DrawNoteFlair(sS: sS, success: true, text: "NEARLY PERFECT", path: userDrawnShape.userDrawnPath)
                } else if a > Float(0.98) {
                    fbFlair = DrawNoteFlair(sS: sS, success: true, text: "VERY GOOD", path: userDrawnShape.userDrawnPath)
                } else {
                    fbFlair = DrawNoteFlair(sS: sS, success: true, text: "GOOD", path: userDrawnShape.userDrawnPath)
                }
                nextStep()
            } else {
                
                if failedAttempts == 0 {
                    fbFlair = DrawNoteFlair(sS: sS, success: false, text: "TRY AGAIN", path: userDrawnShape.userDrawnPath)
                } else if failedAttempts == 1 {
                    fbFlair = DrawNoteFlair(sS: sS, success: false, text: "KEEP TRYING", path: userDrawnShape.userDrawnPath)
                } else if failedAttempts == 2 {
                    fbFlair = DrawNoteFlair(sS: sS, success: false, text: "FOLLOW THE LINE", path: userDrawnShape.userDrawnPath)
                } else {
                    fbFlair = DrawNoteFlair(sS: sS, success: false, text: "ARE YOU FOLLOWING THE LINE?", path: userDrawnShape.userDrawnPath)
                    skipBtn = UIButton(frame: CGRect(x: sS.width * 0.82, y: sS.height * 0.03, width: sS.width * 0.1, height: sS.height * 0.08))
                    skipBtn.setTitle("SKIP", for: .normal)
                    skipBtn.setTitleColor(UIColor.white, for: .normal)
                    skipBtn.titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: sS.height * 0.07)
                    skipBtn.titleLabel?.adjustsFontSizeToFitWidth = true
                    skipBtn.titleLabel?.numberOfLines = 0
                    view.addSubview(skipBtn)
                    skipBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
                }
                failedAttempts += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
                    self.userDrawnShape.quickRemove()
                }
                
                
            }
            
            view.addSubview(fbFlair)
            
        }
        
        
        //
        //        if userDrawnShape.checkDrawing(debug: false) != true {
        //            //                self.userDrawnShape.incorrectAnimation(correctShape: activeShape.path)
        //            self.failedAttempts += 1
        //            if self.failedAttempts > 2 {
        //
        //            } else {
        //
        //            }
        //        } else {
        //            print("correct")
        //        }
        //
        //
    }
    
}

// TUTORIAL TITLES & INSTRUCTIONS

class TutLabel : SpringLabel {
    init(sS: CGSize, delay: TimeInterval, text: String, shouldShow: Bool, position: String){
        var newY:CGFloat = 0.0
        var setFont = UIFont(name: "AmaticSC-Regular", size: 80)
        var newWidth:CGFloat = sS.width*0.8
        var newHeight:CGFloat = sS.height * 0.20
        var newX:CGFloat = sS.width*0.1
        if position == "top" {
            newY = sS.height * 0.2
        } else if position == "bottom" {
            newY = sS.height * 0.75
        } else if position == "right" {
            setFont = UIFont(name: "AmaticSC-Regular", size: 120)
            newY = sS.height * 0.5
            newWidth = sS.width*0.35
        } else if position == "left" {
            setFont = UIFont(name: "AmaticSC-Regular", size: 120)
            newY = sS.height * 0.45
            newWidth = sS.width*0.35
            newX = sS.width*0.1
        } else {
            newY = sS.height * 0.75
        }
        
        super.init(frame: CGRect(x: newX, y: 0, width: newWidth, height: newHeight))
        
        self.font = setFont
        self.textAlignment = .center
        self.text = text
        self.adjustsFontSizeToFitWidth = false
        self.numberOfLines = 0
        self.textColor = UIColor.white
        self.alpha = 0
        self.sizeToFit()
        self.center.y = newY
        if shouldShow { show(delay: delay) }
        
        if position == "top" {
            self.center.x = sS.width*0.5
        } else if position == "bottom" {
            
        } else if position == "right" {
            
        } else if position == "left" {
            
        } else {
            
        }
    }
    
    func show(delay: TimeInterval){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { // change 2 to desired number of seconds
            UIView.animate(withDuration: 2, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.alpha = 1
            }, completion: { finished in
                
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func remove(){
        self.animation = "fadeOut"
        self.curve = "easeIn"
        self.duration = 0.5
        self.animate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
            self.removeFromSuperview()
        }
    }
    
}

class TutImage : SpringImageView {
    init(image: String, frameRect: CGRect, cP: CGPoint, sS: CGSize, delay: TimeInterval){
        super.init(frame: frameRect)
        self.image = UIImage(named: image)
        self.center = CGPoint(x: sS.width * cP.x, y: sS.height * cP.y)
        self.alpha = 0
        show(delay: delay)
    }
    
    func show(delay: TimeInterval){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { // change 2 to desired number of seconds
            UIView.animate(withDuration: 2, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.alpha = 1
            }, completion: { finished in
                
            })
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class IntroView: UIView {
    var titleText : UILabel!
    init(sS: CGSize){
        super.init(frame: CGRect(x: 0, y: 0, width: sS.width, height: sS.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class ProgressBar: UIView {
    var titleText : UILabel!
    var icons : [UIImageView]!
    var sS : CGSize!
    var activeIcon = 5
    
    init(sS: CGSize){
        super.init(frame: CGRect(x: 0, y: (sS.height * 0.85), width: sS.width, height: (sS.height * 0.15)))
        self.sS = sS
        icons = [
            makeIcon(count: 0),
            makeIcon(count: 1),
            makeIcon(count: 2),
            makeIcon(count: 3)
        ]
        for icon in icons {
            self.addSubview(icon)
        }
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func fade(){
        UIView.animate(withDuration: 1.3, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.alpha = 1
        }, completion: { finished in
            
        })
    }
    
    func makeIcon(count: Int) -> UIImageView {
        var image : UIImage!
        var imgC:CGFloat = 0
        switch count {
        case 0:
            image = UIImage(named: "progIcon1")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            imgC = (sS.width * 0.32)
        case 1:
            image = UIImage(named: "progIcon2")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            imgC = (sS.width * 0.44)
        case 2:
            image = UIImage(named: "progIcon3")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            imgC = (sS.width * 0.56)
        case 3:
            image = UIImage(named: "progIcon4")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            imgC = (sS.width * 0.68)
        default:
            image = UIImage(named: "progIconDone")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            print("fail")
        }
        
        var icon = UIImageView(image: image)
        icon.frame = CGRect(x: 0, y: (sS.height * 0.035), width: (sS.height * 0.08), height: (sS.height * 0.08))
        icon.center.x = imgC
        icon.tintColor = UIColor.white
        icon.alpha = 0.6
        return icon
    }
    
    func setActiveIcon(newActiveIcon: Int, delay: TimeInterval){
        if activeIcon == 5 {
            
        } else {
            UIView.animate(withDuration: 1.3, delay:delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
                self.icons[self.activeIcon].transform = CGAffineTransform(scaleX: 1, y: 1)
                self.icons[self.activeIcon].alpha = 0.6
            }, completion: { finished in
                
            })
        }
        
        var factor1:CGFloat = 1 / 1.3
        
        UIView.animate(withDuration: 1.3, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.icons[newActiveIcon].transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.icons[newActiveIcon].alpha = 1
        }, completion: { finished in
            
        })
        
        
        activeIcon = newActiveIcon
    }
    
    func setCompleteIcon(count: Int){
        self.icons[count-1].image = UIImage(named: "progIconDone")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.icons[count-1].tintColor = UIColor.green
    }
    
}

class Dot : UIView {
    var x : CGFloat!
    var y : CGFloat!
    var name : Int!
    var part : String!
    var dotFrame : CGRect!
    var covered : Bool!
    
    init(x: CGFloat, y: CGFloat, name: Int, part: String) {
        super.init(frame: CGRect(x: x, y: y, width: 4, height: 4))
        self.x = x
        self.y = y
        self.name = name
        self.part = part
        self.covered = false
        
        layer.cornerRadius = 2
        clipsToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: self.x, y: self.y, width: 4, height: 4))
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
        layer.cornerRadius = 2
    }
    
}

