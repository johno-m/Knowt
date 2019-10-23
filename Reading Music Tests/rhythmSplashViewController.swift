//
//  rhythmSplashViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 09/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class rhythmSplashViewController: UIViewController {

    @IBOutlet weak var tutSplash: UIImageView!
    @IBOutlet weak var splashImg: UIImageView!
    var splashArray = ["rhythm-splash-1.png"]
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            var tutorialNeeded:Bool = false
            let count = rhythmDifficulty[0]
            var i = 0
            while i < count {
                let checkScore:Int = rhythmScores[i]
                if checkScore < 1 {
                    tutorialNeeded = true
                }
                i+=1
            }
            if tutorialNeeded == true {
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.031, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            } else {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmTutorialViewController") as! rhythmTutorialViewController
                self.present(nextViewController, animated: true, completion: nil)
            }
        }
        
        
        
        
    }
    
    var imgCount = 1
    
    @objc func updateTimer()
    {
        var string = ""
        if imgCount < 10 {
            string = "rhythm-intro000\(imgCount).png"
            splashImg.image = UIImage(named: string)
        }
        if imgCount < 70 && imgCount > 9 {
            string = "rhythm-intro00\(imgCount)"
            splashImg.image = UIImage(named: string)
        }
        if imgCount > 100 {
            timer.invalidate()
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmTutorialViewController") as! rhythmTutorialViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        print(string)
        imgCount += 1
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
