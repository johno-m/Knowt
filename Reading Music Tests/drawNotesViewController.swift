////
////  drawNotesViewController.swift
////  Reading Music Tests
////
////  Created by John Mckay on 15/10/2018.
////  Copyright © 2018 John Mckay. All rights reserved.
////
//
//import UIKit
//
//var sS: CGRect!
//var sW = CGFloat()
//var sH = CGFloat()
//
//class drawNotesViewController: UIViewController {
//
//    var stave = [StaveLine]()
//    var tutorials = [TutorialSlide]()
//    var bgRays = [BgRay]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        sS = UIScreen.main.bounds
//        sW = sS.width
//        sH = sS.height
////        drawStaves()
////        showScene()
//    }
//    
//    func drawStaves(){
//        let giP:CGFloat = sH * 0.08
//        let cP = sH/2
//        
//        let staveLineY:[CGFloat] = [
//            cP-(giP*2),
//            cP-(giP*1),
//            cP-(giP*0),
//            cP+(giP*1),
//            cP+(giP*2)
//        ]
//        
//        for i in 0...4 {
////            stave.append(StaveLine(sW: sW, sH: sH, staveGap: 0.8, staveNum: i, lineY: staveLineY[i], expanded: false))
////            view.addSubview(stave[i])
//        }
//    }
//    
//    func showScene(){
//        bgRays.append(BgRay(bgColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)))
//        bgRays.append(BgRay(bgColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)))
//        for ray in bgRays { view.addSubview(ray) }
//        bgRays[0].center = CGPoint(x: sW*0.5, y: sH*0.5)
//    }
//
//}
//
//class TutorialSlide : UIView {
//    var tutText : String!
//    var screenHeight : CGFloat!
//    var staveGap : CGFloat!
//    var staveNum : Int!
//    var lineY : CGFloat!
//    var expanded : Bool!
//    
//    init(sW: CGFloat, sH: CGFloat, staveGap: CGFloat, staveNum: Int, lineY: CGFloat, expanded: Bool) {
//        self.screenHeight = sH
//        self.staveGap = staveGap
//        self.staveNum = staveNum
//        self.lineY = lineY
//        self.expanded = expanded
//        super.init(frame: CGRect(x: sW*0.1, y: lineY, width: sW*0.8, height: 5))
//        backgroundColor = UIColor.black
//        setStavePositions()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        backgroundColor = UIColor.black
//    }
//    
//    func setStavePositions(){
//        
//    }
//    
//    override func draw(_ rect: CGRect) {
//        
//    }
//}
//
//class BgRay : UIView {
//    var bgColor : UIColor!
//    
//    init(bgColor: UIColor) {
//        super.init(frame: CGRect(x: 0-sW*0.2, y: sH, width: sW*1.4, height: sH*0.3))
//        backgroundColor = bgColor
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        backgroundColor = bgColor
//    }
//}
