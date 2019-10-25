//
//  SettingsVC.swift
//  Reading Music Tests
//
//  Created by John Mckay on 28/02/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    var backBtn : BackBtn!
    
    @IBAction func resetGame(_ sender: Any) {
        deleteUserInf()
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn = BackBtn(color: UIColor.white)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        view.addSubview(backBtn)
        // Do any additional setup after loading the view.
    }
    
    @objc func backBtnPressed(_ sender:UIButton){
        let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated:true, completion:nil)
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
