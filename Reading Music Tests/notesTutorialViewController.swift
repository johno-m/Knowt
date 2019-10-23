//
//  noteTutorialViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 28/07/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

// Notes Intro Tutorial Screen

import UIKit

class notesTutorialViewController: UIViewController {

    var ray1 = UILabel()
    var ray2 = UILabel()
    var ray1Y = CGFloat()
    var ray2Y = CGFloat()
    
    let tutNote = UIImageView()
    
    var tutCount = 0
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var nextBtn_width:CGFloat = 0
    var nextBtn_height:CGFloat = 0
    
    let tutNote1 = SpringImageView()
    let tutNote2 = SpringImageView()
    let tutNote3 = SpringImageView()
    
    let likethis = SpringImageView()
    
    let slidesList = ["tut_stave_step2.png", "tut_stave_step3.png", "tut_stave_step4.png"]
    let tutNotesList = [UIImage(named: "tutNote.png"), UIImage(named: "tutNote.png"), UIImage(named: "tutNote2.png")]
    var tutNotesCont = [SpringImageView()]
    var notesPos = [CGPoint()]
    @IBOutlet weak var nextBtn: SpringButton!
    @IBOutlet weak var tutorialView: SpringImageView!
    @IBOutlet weak var testBtn: UIButton!
    @IBAction func testBtnAction(_ sender: Any) {
        popButton()
    }


    func showSlide(){
        if(tutCount == 0){
            tutorialView.animation = "squeezeDown"
            tutorialView.curve = "easeOut"
            tutorialView.duration = 1
            tutorialView.delay = 2
            tutorialView.image = UIImage(named: slidesList[tutCount])
            tutorialView.alpha = 1
            tutorialView.animate()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.popButton()
            }
            print("Tutorial Count \(tutCount)")
        }
        
        if(tutCount == 1){

            tutorialView.animation = "squeezeDown"
            tutorialView.curve = "easeOut"
            tutorialView.duration = 1
            tutorialView.delay = 2
            tutorialView.image = UIImage(named: slidesList[tutCount])
            tutorialView.animate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.popButton()
            }
            print("Tutorial Count \(tutCount)")
        }
        
        if(tutCount == 2){
            tutorialView.animation = "squeezeDown"
            tutorialView.curve = "easeOut"
            tutorialView.duration = 1
            tutorialView.delay = 2
            tutorialView.image = UIImage(named: slidesList[tutCount])
            tutorialView.animate()
            var j = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                for notes in self.tutNotesList {
                    self.tutNotesCont[j].alpha = 0
                    self.tutNotesCont[j].image = self.self.tutNotesList[j]
                    self.tutNotesCont[j].frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.screenWidth*0.058, height: self.screenHeight*0.191)
                    self.tutNotesCont[j].center = self.notesPos[j]
                    self.view.addSubview(self.tutNotesCont[j])
                    
                    UIView.animate(withDuration: 2, delay: Double(1+j), usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                        self.tutNotesCont[j].alpha = 1
                        
                    }, completion: { finished in
                        // call the animation to pop in Button
                        self.popButton()
                    })
                    
                    self.tutNotesCont[j].animation = "pop"
                    self.tutNotesCont[j].curve = "easeOut"
                    self.tutNotesCont[j].duration = 1
                    self.tutNotesCont[j].delay = CGFloat(1+j)
                     self.tutNotesCont[j].alpha = 0
                    self.tutNotesCont[j].animate()
                    
                    j += 1
                }
            }
            likethis.image = UIImage(named: "likethis.png")
            likethis.frame = CGRect(x: 0, y: 0, width: screenWidth*0.093, height: screenHeight*0.042)
            likethis.center = CGPoint(x: screenWidth/2, y: screenHeight*0.34)
            likethis.alpha = 0
            self.view.addSubview(likethis)
            
            
            UIView.animate(withDuration: 2, delay: 6, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.likethis.alpha = 1
            }, completion: { finished in
                // call the animation to pop in Button
            })
            
        }
        
        if(tutCount > 2){
            //end
            changeScreen()
        }
    }
    
    func changeSlide(){
        tutCount += 1
        tutorialView.animation = "fall"
        tutorialView.delay = 0
        tutorialView.curve = "easeIn"
        tutorialView.duration = 1
        tutorialView.animate()
        showSlide()
    }
    
    func popButton(){
        
        self.nextBtn.isHidden = false
        self.nextBtn.animation = "fadeIn"
        self.nextBtn.curve = "easeOut"
        self.nextBtn.duration =  1.0
        self.nextBtn.delay =  1.0
        self.nextBtn.animate()
        self.nextBtn.animation = "pop"
        self.nextBtn.curve = "easeOut"
        self.nextBtn.duration =  1.0
        self.nextBtn.delay =  1.0
        self.nextBtn.animate()
    }
    
    func finalSlideAnims(){
        
    }
    
    override func viewDidLoad() {
        print("Tutorial complete? \(usrInf.tutsComplete["notesIntro"])")
        if usrInf.tutsComplete["notesIntro"] == true {
            
        } else {
            ray1.frame = CGRect(x: 0, y: screenHeight, width: (screenWidth*2), height: screenHeight)
            ray1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
            ray1Y = 0 - (screenHeight * 0.3)
            ray2.frame = CGRect(x: 0, y: screenHeight, width: (screenWidth*2), height: screenHeight)
            ray2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
            ray2Y = (screenHeight * 1.3)
            self.view.addSubview(ray1)
            self.view.addSubview(ray2)
            nextBtn.alpha = 0
            nextBtn.setImage(UIImage(named: "next_btn.png"), for: .normal)
            
            notesPos = [CGPoint(x: screenWidth * 0.385, y: screenHeight * 0.47), CGPoint(x: screenWidth * 0.546, y: screenHeight * 0.445), CGPoint(x: screenWidth * 0.693, y: screenHeight * 0.539)]
            tutNotesCont = [tutNote1,tutNote2,tutNote3]
            
            tutorialView.alpha = 0
        }
        
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if usrInf.tutsComplete["notesIntro"] != true {
            startAnim(target: ray1, toY: ray1Y, angle: -28.5)
            startAnim(target: ray2, toY: ray2Y, angle: -4.6)
            showSlide()
        } else {
            changeScreen()
        }
        
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
    
    func changeScreen(){
        usrInf.tutsComplete["notesIntro"] = true
        saveUserInf()
        print("changeScreen function called")
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorial2ViewController") as! notesTutorial2ViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
        
    }

    @IBAction func nextButtonAction(_ sender: SpringButton) {
        sender.alpha = 0
        changeSlide();
    }
    
}
