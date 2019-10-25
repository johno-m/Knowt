//
//  noteProgressViewController.swift
//  Reading Music Tests
//
//  Created by John Mckay on 30/07/2018.
//  Copyright © 2018 John Mckay. All rights reserved.
//

import UIKit

class noteProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var progressTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var unlockedNotes : [String]!
    var unlockedNotesInOrder = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInf()
        progressTable.delegate = self
        progressTable.dataSource = self
        unlockedNotes = [String]()
        
        let allTrebleNotes = noteLevelList[usrInf.instrument]
        let allBassNotes = noteLevelList[usrInf.instrument]
        
        if usrInf.prefStave == "treble" {
            for i in 0...usrInf.treblelevel {
                for note in allTrebleNotes![i] {
                    unlockedNotes.append(note)
                }
            }
        }
        if usrInf.prefStave == "bass" {
            for i in 0...usrInf.basslevel {
                for note in allBassNotes![i] {
                    unlockedNotes.append(note)
                }
            }
        }
        
        segmentedControl.subviews.flatMap{$0.subviews}.forEach { subview in
            if let imageView = subview as? UIImageView, imageView.frame.width > 5 {
                imageView.contentMode = .scaleAspectFit
            }
        }
        
        for note in noteList {
            for n in unlockedNotes {
                if n == note {
                    unlockedNotesInOrder.append(n)
                }
            }
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 200
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 200
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unlockedNotes.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = progressTable.dequeueReusableCell(withIdentifier: "cell") as! ProgressViewCell
        cell.buildCell(i: indexPath.row, note: unlockedNotesInOrder[indexPath.row])
        cell.updateConstraints()
        return cell
    }
    
    
}

