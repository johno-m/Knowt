//
//  notePromoteViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 07/08/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class notePromoteViewController: UIViewController {

    @IBOutlet weak var titleGuide: UILabel!
    @IBOutlet weak var rays: UIImageView!
    @IBOutlet weak var levelLabel: SpringLabel!
    var titleImage: SpringImageView = SpringImageView()
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        loadUserInf()
        let currentUserLevels = noteLevelList[usrInf.instrument]
        let numberOfUserLevels = (currentUserLevels?.count)! - 1
        if usrInf.treblelevel >= numberOfUserLevels {
            print("USER HAS REACHED MAX LEVEL - SHOULD NOT BE HERE")
            if actionToDo == "MainMenu" {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
            }
            if actionToDo == "PlayAgain" {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorial2ViewController") as! notesTutorial2ViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
            }
            if actionToDo != "MainMenu" && actionToDo != "PlayAgain" {
                print("No action passed by previous View")
            }
            
        } else {
            print("USER HAS NOT REACHED MAX LEVEL")
            print("currentUserLevels = \(String(describing: currentUserLevels))")
            print("numberOfUserLevels = \(numberOfUserLevels)")
            print("trebleLevel = \(usrInf.treblelevel)")
            continueButton.isHidden = true
            levelLabel.text = "\(usrInf.treblelevel)"
            
            if usrInf.treblelevel == numberOfUserLevels || usrInf.treblelevel > numberOfUserLevels {
                print("Max Level Reached!!!")
                usrInf.userTrebleMaxLevelReached = true
                showMaxLevel()
            } else {
                usrInf.userTrebleMaxLevelReached = false
               
                if checkPromotionCriteria(stave: usrInf.prefStave) {
                    print("User has reached target")
                    usrInf.treblelevel += 1
                    saveUserInf()
                    if (usrInf.treblelevel == numberOfUserLevels){
                        print("User Level: \(usrInf.treblelevel)")
                        print("numberOfUserLevels: \(numberOfUserLevels)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                            self.showFinalRoundImage()
                        }
                        
                    }
                } else {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController, animated: true, completion: nil)
                }
                
                
            }
            super.viewDidLoad()
            rayAnimation()
            setScene()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // change 2 to desired number of seconds
                self.popNumber()
            }
        
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        let currentUserLevels = noteLevelList[usrInf.instrument]
        let numberOfUserLevels = (currentUserLevels?.count)! - 1
        showButton()
        
    }
    
    func setScene(){
        let screenSize = UIScreen.main.bounds
        let screenWidth:CGFloat = screenSize.width
        let screenHeight:CGFloat = screenSize.height
        let imageWidth:CGFloat = CGFloat(screenWidth * 0.7)
        let centerX:CGFloat = CGFloat(screenWidth*0.5)
        let ratio:CGFloat = 519/1913
        let centerY:CGFloat = CGFloat(screenWidth * 0.7) * ratio
        
        titleImage.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth*ratio)
        titleImage.center = CGPoint(x: centerX, y: centerY)
        titleImage.image = UIImage(named: "promotionTitle.png")
        view.addSubview(titleImage)
        titleImage.delay = 1
        titleImage.animation = "squeezeDown"
        titleImage.duration = 0.5
        titleImage.curve = "easeIn"
        titleImage.animate()
    }
    
    func popNumber(){
        levelLabel.animation = "wobble"
        levelLabel.duration = 0.5
        levelLabel.curve = "easeIn"
        levelLabel.animate()
        levelLabel.text = "\(usrInf.treblelevel)"
    }
    
    func showMaxLevel(){
        // add in some animation to make it clear this is the final round and no more notes will be shown.
    }
    
    func showButton(){
        let screenSize = UIScreen.main.bounds
        let screenWidth:CGFloat = screenSize.width
        let screenHeight:CGFloat = screenSize.height
        
        let buttonWidth = screenWidth*0.25
        let buttonHeight = (buttonWidth / 438) * 137
        continueButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        
        continueButton.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        continueButton.isHidden = false
        
        UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
            self.continueButton.center.y = screenHeight * 0.85

        }, completion: { finished in
            
        })
    }
    
    func rayAnimation(){
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1.73, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.rays.transform = CGAffineTransform(rotationAngle: 0.294118)
        }, completion: { finished in
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1.73, initialSpringVelocity: 0, options: .curveLinear, animations: {
                self.rays.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: { finished in
                self.rayAnimation()
                
            })
        })
        
    }
    @IBAction func continueButton(_ sender: Any) {
        if actionToDo == "MainMenu" {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        if actionToDo == "PlayAgain" {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorial2ViewController") as! notesTutorial2ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        if actionToDo != "MainMenu" && actionToDo != "PlayAgain" {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func showFinalRoundImage(){
        let coverImage = SpringImageView()
        let screenSize = UIScreen.main.bounds
        let screenWidth:CGFloat = screenSize.width
        let screenHeight:CGFloat = screenSize.height
        let imageWidth:CGFloat = CGFloat(screenWidth * 0.7)
        let centerX:CGFloat = CGFloat(screenWidth*0.5)
        let ratio:CGFloat = 519/1913
        let centerY:CGFloat = CGFloat(screenWidth * 0.7) * ratio
        
        coverImage.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth*ratio)
        coverImage.center = CGPoint(x: centerX, y: centerY)
        coverImage.image = UIImage(named: "promotionTitleFinal.png")
        view.addSubview(coverImage)
        coverImage.delay = 1
        coverImage.animation = "squeezeDown"
        coverImage.duration = 0.5
        coverImage.curve = "easeIn"
        coverImage.animate()
        print("showFinalRoundImage Called")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
