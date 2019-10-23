//
//  ViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 23/07/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var instrumentAnnouncer: UILabel!
    @IBOutlet weak var trebleLevelAnnouncer: UILabel!
    @IBOutlet weak var bassLevelAnnouncer: UILabel!
    let path = UIBezierPath()
    let path2 = UIBezierPath()
    let path3 = UIBezierPath()
    let path4 = UIBezierPath()
    let path5 = UIBezierPath()
    let menuButtons = UIButton()
    let menuButtonsImage = UIImageView()
    
    func drawShape(){
//         check to see if the instrument var is set. If it is then check to see if the max level has been reached.
        
        if usrInf.instrument == "unset" {
            instrumentAnnouncer.text = ""
        } else {
            instrumentAnnouncer.text = "\(usrInf.instrument)"
            
            if(usrInf.treblelevel == (trebleNotes.count-1)){
                trebleLevelAnnouncer.text = "Max"
            } else {
                trebleLevelAnnouncer.text = "\(usrInf.treblelevel)"
            }
            if(usrInf.basslevel == (bassNotes.count-1)){
                trebleLevelAnnouncer.text = "Max"
            } else {
                bassLevelAnnouncer.text = "\(usrInf.basslevel)"
            }
        }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        path.move(to: CGPoint(x: 0, y: screenHeight*0.70))
        path.addLine(to: CGPoint(x: 0, y: screenHeight*0.80))
        path.addLine(to: CGPoint(x: screenWidth, y: screenHeight*0.50))
        path.addLine(to: CGPoint(x: screenWidth, y: screenHeight*0.25))
        path.close()
        path2.move(to: CGPoint(x: 0, y: screenHeight*0.80))
        path2.addLine(to: CGPoint(x: 0, y: screenHeight*0.90))
        path2.addLine(to: CGPoint(x: screenWidth, y: screenHeight*0.75))
        path2.addLine(to: CGPoint(x: screenWidth, y: screenHeight*0.50))
        path2.close()
        path3.move(to: CGPoint(x: 0, y: screenHeight*0.90))
        path3.addLine(to: CGPoint(x: 0, y: screenHeight))
        path3.addLine(to: CGPoint(x: screenWidth, y: screenHeight))
        path3.addLine(to: CGPoint(x: screenWidth, y: screenHeight*0.75))
        path3.close()
        path5.move(to: CGPoint(x: screenWidth*0.93, y: 0))
        path5.addLine(to: CGPoint(x: screenWidth*0.93, y: screenHeight*0.12))
        path5.addLine(to: CGPoint(x: screenWidth, y: screenHeight))
        path5.addLine(to: CGPoint(x: screenWidth, y: 0))
        path5.close()
        
    }

    var ray0 = UIImageView()
    var ray1 = UIImageView()
    var ray2 = UIImageView()
    var ray3 = UIImageView()
    var buttonsActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInf()
        print("User Info: \(usrInf)")
        for note in trebleNotes {
            print(note)
        }
        drawShape()
        //let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.checkAction(sender:)))
        //self.menuButtons.addGestureRecognizer(gesture)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let rayHolder = [ray0, ray1, ray2, ray3]
        let rayAngle:[CGFloat] = [-18.36, -18.23, -12.36, -6.29]
        let rayDelays = [0.5, 0.8, 1, 1.5]
        let rayY:[CGFloat] = [0.71, 0.735, 0.896, 1.065]
        let rayImages = [UIImage(named: "borderRay"), UIImage(named: "orangeRay"), UIImage(named: "pinkRay"), UIImage(named: "tealRay")]
        
        let frame_x = 0 - (((screenWidth * 1.27)-screenWidth) / 2)
        
        var i = 0
        for ray in rayHolder {
            ray.frame = CGRect(x: frame_x, y: screenHeight, width: screenWidth * 1.27, height: (screenWidth * 1.27)/3.625)
            ray.image = rayImages[i]
            ray.alpha = 1
            
            self.view.addSubview(ray)
            i += 1
            ray0.alpha = 0.2
        }
        self.buttonsActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(usrInf.instrument == "unset"){
            print("No instrument is set...")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "setupStep1") as! setupStep1
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated:true, completion:nil)
        } else {
            
        }
        var i = 0
        let rayHolder = [ray0, ray1, ray2, ray3]
        let rayAngle:[CGFloat] = [-18.36, -18.23, -12.36, -6.29]
        let rayDelays = [0.5, 0.8, 1, 1.5]
        let rayY:[CGFloat] = [0.71, 0.735, 0.896, 1.065]
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let height = UIApplication.shared.statusBarFrame.size.height
        menuButtonsImage.frame = CGRect(x: 0, y: height, width: screenWidth, height: screenHeight - height)
        menuButtonsImage.alpha = 0
        menuButtonsImage.image = UIImage(named: "menuButtons")
        self.view.addSubview(menuButtonsImage)
        
        for ray in rayHolder {
            UIView.animate(withDuration: 2, delay:rayDelays[i], usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                let radians = CGFloat(Double.pi / 180) * rayAngle[i]
                ray.transform = CGAffineTransform(rotationAngle: radians)
                ray.center = CGPoint(x: screenWidth/2, y: screenHeight * rayY[i])
            }, completion: { finished in
                UIView.animate(withDuration: 2, delay:0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.menuButtonsImage.alpha = 1
                }, completion: { finished in
                    print(self.menuButtonsImage.alpha)
                })
            })
            i += 1
        }
        
    }
    
    public func hitTest(tapLocation:CGPoint){
        if buttonsActive == true {
            if path.contains(tapLocation){
                self.buttonsActive = false
                noteGameType = "note"
                print("path1")
                if usrInf.tutsComplete["notesIntro"] == true {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorial2ViewController") as! notesTutorial2ViewController
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController, animated: true, completion: nil)
                } else {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesTutorialViewController") as! notesTutorialViewController
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController, animated: true, completion: nil)
                }
                
                
            }
            if path2.contains(tapLocation){
                self.buttonsActive = false
                noteGameType = "free"
                print("path2")
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "selectNotesViewController") as! selectNotesViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
            }
            if path3.contains(tapLocation){

                usrInf.treblelevel += 1
                saveUserInf()
                 let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                 nextViewController.modalPresentationStyle = .fullScreen
                 self.present(nextViewController, animated: true, completion: nil)
                /*
                self.buttonsActive = false
                print("path3")
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "selectNotesViewController") as! selectNotesViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
 */
            }
            if path5.contains(tapLocation){
                self.buttonsActive = false
                print("path5")
                usrInf.treblelevel += 1
                 let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                 nextViewController.modalPresentationStyle = .fullScreen
                 self.present(nextViewController, animated: true, completion: nil)
                
                /*
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
 
                 */
            }

        } else {
            print("User clicked button prior to Button Active")
        }
    }
    
    @IBAction func settingsBtn(_ sender: Any) {

        usrInf.treblelevel += 1
        saveUserInf()
         let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
         nextViewController.modalPresentationStyle = .fullScreen
         self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func screenPressed(_ sender: UIGestureRecognizer) {
        let location = sender.location(in: view)
        print(location)
        hitTest(tapLocation: location)
    }
    
    
}



