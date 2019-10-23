//
//  rhythmEndViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 15/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class rhythmEndViewController: UIViewController {

    @IBOutlet weak var showScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let finalScore:Int = Int(round((Float(rhythmGameScore) / Float(8) * 100)))
        showScore.text = String(finalScore)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
