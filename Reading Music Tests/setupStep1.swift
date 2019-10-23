//
//  setupStep1.swift
//  Reading Music Tests
//
//  Created by John Mckay on 02/06/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class setupStep1: UIViewController {

    @IBAction func button1(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "setupStep2") as! setupStep2
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func button2(_ sender: Any) {
        usrInf.instrument = "None"
        saveUserInf()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
