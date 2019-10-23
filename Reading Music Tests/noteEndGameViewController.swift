//
//  noteEndGameViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 09/08/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class noteEndGameViewController: UIViewController {

    @IBOutlet weak var rays: UIImageView!
    @IBOutlet weak var reachedTheEndImage: SpringImageView!
    @IBOutlet weak var reachedTheEndText: SpringImageView!
    @IBOutlet weak var stamp: UIImageView!
    @IBOutlet weak var keepPlayingButton: SpringButton!
    
    override func viewDidLoad() {
        finalScreenPlayedOut = true
        saveUserInf()
        super.viewDidLoad()
        rayAnimation()
        reachedTheEndText.alpha = 0
        keepPlayingButton.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dropIn(target: reachedTheEndImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
            self.reachedTheEndText.alpha = 1
            self.dropIn(target: self.reachedTheEndText)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // change 2 to desired number of seconds
            self.keepPlayingButton.alpha = 1
            self.dropInBtn(target: self.keepPlayingButton)
        }
    }
    @IBAction func keepPlaying(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dropIn(target: SpringImageView){
        target.animation = "fadeInDown"
        target.duration = 0.5
        target.curve = "easeIn"
        target.animate()
    }
    func dropInBtn(target: SpringButton){
        target.animation = "fadeInDown"
        target.duration = 0.5
        target.curve = "easeIn"
        target.animate()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
