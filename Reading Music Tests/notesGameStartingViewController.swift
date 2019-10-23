
//
//  notesGameStartingViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 18/08/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class notesGameStartingViewController: UIViewController {

    let screenWidth = UIScreen.main.bounds.width
    @IBOutlet weak var getReadySplash: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            
        }, completion: { finished in
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "notesViewController") as! notesViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
            }
        })
        
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
