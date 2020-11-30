//
//  selectNotesViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 29/09/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class selectNotesViewController: UIViewController {
    
    let noteList = [
        "E1", "F1"
    ]

    @IBAction func notePressed(_ sender: UIButton) {
        let i = sender.tag
        
    }
    
    @IBOutlet weak var noteScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
