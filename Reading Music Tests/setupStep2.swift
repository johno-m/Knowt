//
//  setupStep2.swift
//  Reading Music Tests
//
//  Created by John Mckay on 02/06/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class setupStep2: UIViewController {

    @IBAction func piano(_ sender: Any) {
        usrInf.instrument = "Piano"
        saveUserInf()
        changeScreen()
    }

    @IBAction func ukulele(_ sender: Any) {
        usrInf.instrument = "Ukulele"
        saveUserInf()
        changeScreen()
    }
    @IBAction func guitar(_ sender: Any) {
        usrInf.instrument = "Guitar"
        saveUserInf()
        changeScreen()
    }
    
    @IBAction func violin(_ sender: Any) {
        usrInf.instrument = "Violin"
        saveUserInf()
        changeScreen()
    }
    @IBAction func none(_ sender: Any) {
        usrInf.instrument = "None"
        saveUserInf()
        changeScreen()
    }
    
    func changeScreen(){
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
