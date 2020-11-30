//
//  notesTutorial2ViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 31/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class notesTutorial2ViewController: UIViewController, UIScrollViewDelegate {

    var ray1 = UILabel()
    var ray2 = UILabel()
    var ray1Y = CGFloat()
    var ray2Y = CGFloat()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let sW = UIScreen.main.bounds.width
    let sH = UIScreen.main.bounds.height
    var allNotesInGame = [String()]
    var notesInTutorial = [String()]
    @IBOutlet weak var bgView: GradientView!
    @IBOutlet weak var tutorialScroll: UIScrollView!
    var backBtn : BackBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUserNotes = noteLevelList[usrInf.instrument]
        let numberOfLevels = (currentUserNotes?.count)! - 1
        print("number of Levels: \(numberOfLevels)")
        if(usrInf.treblelevel > numberOfLevels) {
            if usrInf.treblelevel > numberOfLevels {
                usrInf.treblelevel = numberOfLevels
            }
        } else {
            
        }
        notesToLearn()
        
        backBtn = BackBtn(color: UIColor.white)
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        
        tutorialScroll.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showRays()
        startAnim(target: ray1, toY: ray1Y, angle: -28.5)
        startAnim(target: ray2, toY: ray2Y, angle: -4.6)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func notesToLearn(){
        var i = 0
        let instrumentNoteLevels = noteLevelList[usrInf.instrument]
        let ceil = usrInf.treblelevel+1
        while i < ceil {
            for note in instrumentNoteLevels![i] {
                allNotesInGame.append(note)
            }
            i += 1
        }
        allNotesInGame.remove(at: 0)
        
        for note in allNotesInGame {
            print(note)
            if (trebleNotes[note]?.score)! < 1 {
                notesInTutorial.append(note)
            }
        }
        notesInTutorial.remove(at: 0)
        print("User Level: \(usrInf.treblelevel)")
        print("Notes that should be learnt: \(allNotesInGame)")
        print("Notes that need to be learnt: \(notesInTutorial)")
    }
    
    // *********** Below this line are completed functions (ish) ***************** //
    
    func showRays(){
        ray1.frame = CGRect(x: 0, y: screenHeight, width: (screenWidth*2), height: screenHeight)
        ray1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
        ray1Y = 0 - (screenHeight * 0.3)
        ray2.frame = CGRect(x: 0, y: screenHeight, width: (screenWidth*2), height: screenHeight)
        ray2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
        ray2Y = (screenHeight * 1.3)
        self.view.addSubview(ray1)
        self.view.addSubview(ray2)
    }
    
    func startAnim(target: UILabel, toY: CGFloat, angle: CGFloat){
        UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let radians = CGFloat(Double.pi / 180) * angle
            target.transform = CGAffineTransform(rotationAngle: radians)
            target.center = CGPoint(x: self.screenWidth/2, y: toY)
        }, completion: { finished in
            // call the animation to pop in Button
            
        })
    }

    @objc func backBtnPressed(_ sender:UIButton){
        let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    
}
