//
//  TableViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 28/10/2017.
//  Copyright © 2017 John Mckay. All rights reserved.
//

import UIKit

class DevViewController: UITableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = noteList[row]
        let score = "\(allNotes[noteList[row]])"
        cell.detailTextLabel?.text = score
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 

}
