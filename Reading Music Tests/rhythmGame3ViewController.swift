//
//  rhythmGame3ViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 12/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class rhythmGame3ViewController: UIViewController {

    @IBOutlet weak var loadingBarBG: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var loadingBar: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var cover: UILabel!
    @IBOutlet weak var loadCover: UILabel!
    var beatIndex = Int()
    var correctAnswer = Int()
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            print("Correct!")
            rhythmScores[beatIndex] += 20
        } else {
            print("WRONG!")
            rhythmScores[beatIndex] -= 20
        }
        saveUserInf()
        loadingBar.alpha = 0
        loadingBarBG.alpha = 0
        alertLabel.alpha = 0
        loadingBar.isHidden = false
        loadingBarBG.isHidden = false
        alertLabel.isHidden = false
        cover.isHidden = false
        loadingBar.translatesAutoresizingMaskIntoConstraints = true
        loadingBar.frame.size.width = 0
        UIView.animate(withDuration: 1, animations: {
            self.cover.alpha = 1
            self.loadingBar.alpha = 1
            self.loadingBarBG.alpha = 1
            self.alertLabel.alpha = 1
        }, completion: { finished in
            if(finished){
                UIView.animate(withDuration: 2, animations: {
                    self.loadingBar.frame.size.width = self.alertLabel.frame.width
                }, completion: { finished in
                    if(finished){
                        self.endRound()
                    }
                })
            }
        })
    }
    
    func startRound(){
        rhythmRound += 1
        if rhythmRound < 8 {
            chooseQuestion()
            UIView.animate(withDuration: 1, animations: {
                self.loadCover.alpha = 0
            }, completion: { finished in
                if(finished){
                    self.loadCover.isHidden = true
                }
            })
        } else {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmEndViewController") as! rhythmEndViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func chooseQuestion(){
        let rand = Int(arc4random_uniform(UInt32(rhythmDifficulty[userLevel[2]])))
        beatIndex = rand
        correctAnswer = rhythmGame2Answers[rand]
        questionImage.image = UIImage(named: rhythmGame2Questions[rand][0])
        button1.setTitle(rhythmGame2Questions[rand][1], for: .normal)
        button2.setTitle(rhythmGame2Questions[rand][2], for: .normal)
        button3.setTitle(rhythmGame2Questions[rand][3], for: .normal)
        button4.setTitle(rhythmGame2Questions[rand][4], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingBar.isHidden = true
        loadingBarBG.isHidden = true
        alertLabel.isHidden = true
        cover.alpha = 0
        loadCover.alpha = 1
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endRound(){
        let rand = Int(arc4random_uniform(9))
        print(" ")
        print("Load next game. Random num: \(rand)")
        print(" ")
        if rand < 3 {
            print("Load game 1")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame1ViewController") as! rhythmGame1ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        if rand > 2 && rand < 6 {
            print("Load game 2")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame2ViewController") as! rhythmGame2ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        if rand > 5 && rand < 9 {
            print("Load game 3")
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "rhythmGame3ViewController") as! rhythmGame3ViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
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
